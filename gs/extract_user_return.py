import argparse, sys, datetime
from menagerie.formatting import tsv
from menagerie.decorators import memoized
from mwutil import api
from mwutil.lib import title

from . import database

HEADERS = [
	'wiki_db',
	'user_id',
	'return_namespace',
	'return_title'
]

def read_user_returns(f):
	if not f.isatty():
		return tsv.Reader(f)


def main():
	parser = argparse.ArgumentParser(
		description="""
			Splits the returnTo field in ServerSideAccountCreation into a 
			namespace ID and normalized page title.
		""",
		conflict_handler="resolve"
	)
	parser.add_argument(
		'--user-returns',
		help="The path to a file containing user returns",
		type=lambda path: read_user_returns(open(path)),
		default=read_user_returns(sys.stdin)
	)
	
	args = parser.parse_args()
	
	run(args.user_returns)
	
def run(user_returns):
	
	writer = tsv.Writer(sys.stdout, headers=HEADERS)
	
	for row in user_returns:
		
		namespaces = get_namespace(row.wiki)
		if row.event_returnTo is not None:
			ns_id, title = namespaces.parse(row.event_returnTo)
		else:
			ns_id = None
			title = None
		
		writer.write([row.wiki, row.event_userId, ns_id, title])
	
	
	


@memoized
def get_namespaces(wiki):
	prefix = wiki[:2]
	url = "https://{0}.wikipedia.org/w/api.php".format(prefix)
	session = api.Session(url)
	si_doc = session.site_info.query(properties={"namespaces", "namespacealiases"})
	
	return title.Namespaces.from_site_info(si_doc)
