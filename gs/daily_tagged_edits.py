import argparse, sys, datetime
from menagerie.formatting import tsv

from . import database

def read_wikis(f):
	if not f.isatty():
		return list(row.wiki_db for row in tsv.Reader(f))
	


def main():
	
	parser = argparse.ArgumentParser(
		description = """
			Gathers a set of daily edit counts for a tag across a set of wikis.
		""",
		conflict_handler = "resolve"
	)
	parser.add_argument(
		'wikis',
		help="A file containing the list of wikis to process.",
		type=lambda path: read_wikis(open(path))
	)
	parser.add_argument(
		"tag",
		help="The tag to look for"
	)
	parser.add_argument(
		'--start-day',
		help="A day to start querying.  ",
		type=lambda string: datetime.datetime.strptime(string, "%Y%m%d"),
		default=datetime.datetime.strptime("20130110", "%Y%m%d")
	)
	parser.add_argument(
		'--end-day',
		help="A day to stop querying.  Defaults to today (UTC).",
		type=lambda string: datetime.datetime.strptime(string, "%Y%m%d"),
		default=datetime.datetime.utcnow()
	)
	
	args = parser.parse_args()
	
	run(
		args.wikis, 
		args.tag,
		args.start_day, 
		args.end_day
	)


def run(wikis, tag, start_day, end_day):
	
	writer = tsv.Writer(
		sys.stdout,
		headers=['date'] + wikis
	)
	
	daily_edits = {}
	for wiki in wikis:
		for date, edits in get_daily_tagged_edits(wiki, tag):
			daily_edits[(wiki, date)] = edits
		
	
	for date in dates_between(start_day, end_day):
		values = [date]
		for wiki in wikis:
			values.append(daily_edits.get((wiki, date), 0))
			
		writer.write(values)

def dates_between(start_day, end_day):
	
	current_day = start_day
	while current_day < end_day:
		yield current_day.strftime("%Y-%m-%d")
		current_day += datetime.timedelta(1)

def get_daily_tagged_edits(wiki, tag):
	
	conn = database.connection(wiki)
	cursor = conn.cursor()
	cursor.execute(
		"""
		SELECT
			DATE_FORMAT(LEFT(rev_timestamp, 8), "%Y-%m-%d") AS date,
			COUNT(rev_id) AS edits
		FROM revision
		INNER JOIN change_tag ON
			ct_rev_id = rev_id AND
			ct_tag = ?
		GROUP BY 1
		""",
		[tag]
	)
	
	dialy_edits = {}
	for row in cursor:
		yield row['date'], row['edits']
	
	
