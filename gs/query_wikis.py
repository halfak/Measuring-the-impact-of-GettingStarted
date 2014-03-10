import argparse, sys, datetime, oursql
from menagerie.formatting import tsv

from . import database

def read_wikis(f):
	if not f.isatty():
		return list(row.wiki for row in tsv.Reader(f))
	

def read_query(f):
	if not f.isatty():
		return f.read()

def main():
	
	parser = argparse.ArgumentParser(
		description = """
			Queries a set of wikis and aggregates results
		""",
		conflict_handler = "resolve"
	)
	parser.add_argument(
		'wikis',
		help="A file containing the list of wikis to process.",
		type=lambda path: read_wikis(open(path))
	)
	parser.add_argument(
		'--query',
		help="The query to run.",
		type=lambda path: read_query(open(path))
	)
	
	args = parser.parse_args()
	
	run(
		args.wikis, 
		args.query
	)


def run(wikis, query):
	
	# Will initialize when we receieve the first row
	writer = None
	
	for wiki in wikis:
		conn = database.connection(wiki)
		cursor = conn.cursor(oursql.Cursor)
		cursor.execute(query)
		
		for row in cursor:
			if writer == None: writer = initialize_writer([d[0] for d in cursor.description])
			
			writer.write(row)
			
		
	

def initialize_writer(headers):
	return tsv.Writer(sys.stdout, headers=headers)
