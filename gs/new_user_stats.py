# Requires python3
import argparse, sys, getpass

from mwutil import database
from mwutil.types import Timestamp
from mwutil.lib import sessions
from menagerie.formatting import tsv

from .database import wiki_host

HEADERS = [
	"wiki_db",
	"user_id", 
	"registration_approx",
	"day_revisions",
	"day_main_revisions",
	"day_reverted_main_revisions",
	"week_revisions",
	"week_main_revisions",
	"week_reverted_main_revisions",
	"week_sessions",
	"week_session_seconds"
]

def parse_users(f):
	if not f.isatty():
		return tsv.Reader(f, types=[str, int, str, str])

def main():
	
	parser = argparse.ArgumentParser(
		description = "Takes a list of users and the data necessary to make " + 
		              "judgements about productivity",
		conflict_handler="resolve"
	)
	parser.add_argument(
		"--users",
		help="Input file containing a list of user_ids",
		type=lambda path: parse_users(open(path)),
		default=parse_users(sys.stdin)
	)
	parser.add_argument(
		"-u", "--dbuser",
		help="Which userId to connect with",
		type=str,
		default=getpass.getuser()
	)
	parser.add_argument(
		"--defaults-file",
		help="defaults file to read from"
	)
	parser.add_argument(
		"--revert_cutoff",
		help="How long to wait for a revert to occur? (seconds)",
		type=int,
		default=60*60*24*2 # Two days
	)
	parser.add_argument(
		"--revert_radius",
		help="How many revisions can a reverting revision revert?",
		type=int,
		default=15
	)
	parser.add_argument(
		"--no-headers",
		help="Skip printing the headers",
		action="store_true"
	)
	
	args = parser.parse_args()
	
	dbcache = DBCache(args.dbuser, args.defaults_file)
	
	run(dbcache, args.users, args.revert_cutoff, args.revert_radius, args.no_headers)

class DBCache:
	
	def __init__(self, user, defaults):
		
		self.user = user
		self.defaults = defaults
		
		self.cache = {}
	
	def get_db(self, wiki):
		if wiki in self.cache:
			db = self.cache[wiki]
		else:
			db = database.DB(
				host=wiki_host(wiki),
				user=self.user,
				db=wiki,
				read_default_file=self.defaults
			)
			self.cache[wiki] = db
		
		return db

def run(dbcache, users, revert_cutoff, revert_radius, no_headers):
	
	if no_headers:
		headers=None
	else:
		headers=HEADERS
	
	output = tsv.Writer(sys.stdout, headers=headers)
	
	for user in users:
		db = dbcache.get_db(user.wiki)
		
		sys.stderr.write("{0}, {1}: ".format(user.wiki, user.user_id))
		day_revisions = 0
		day_main_revisions = 0
		day_reverted_main_revisions = 0
		week_revisions = 0
		week_main_revisions = 0
		week_reverted_main_revisions = 0
		week_sessions = 0
		week_session_seconds = 0
		
		registration = Timestamp(user.user_registration)
		end_of_life = Timestamp(int(registration) + 60*60*24*7) # One week
		
		user_revisions = db.revisions.query(
			user_id=user.user_id, 
			direction="newer",
			before=end_of_life,
			include_page=True
		)
		
		revision_events = ((rev['rev_user'], rev['rev_timestamp'], rev) for rev in user_revisions)
		
		for _, session in sessions.sessions(revision_events):
			
			for rev in session:
				day = Timestamp(rev['rev_timestamp']) - registration <= 60*60*24 # one day
				
				week_revisions += 1
				day_revisions += day
				
				if rev['page_namespace'] == 0:
					week_main_revisions += 1
					day_main_revisions += day
					
					rev_timestamp = Timestamp(rev['rev_timestamp'])
					cutoff_timestamp = Timestamp(int(rev_timestamp) + revert_cutoff)
					
					revert = db.revisions.revert(rev, radius=revert_radius,
													  before=cutoff_timestamp)
					
					if revert != None: # Reverted edit!
						week_reverted_main_revisions += 1
						day_reverted_main_revisions += day
						sys.stderr.write("r")
					else:
						sys.stderr.write(".")
				else:
					sys.stderr.write("_")
				
			
			week_sessions += 1
			week_session_seconds += Timestamp(session[-1]['rev_timestamp']) - \
			                        Timestamp(session[0]['rev_timestamp'])
			
			
		
		sys.stderr.write("\n")
		output.write([
			user.wiki,
			user.user_id,
			day_revisions,
			day_main_revisions,
			day_reverted_main_revisions,
			week_revisions,
			week_main_revisions,
			week_reverted_main_revisions,
			week_sessions,
			week_session_seconds
		])
	
