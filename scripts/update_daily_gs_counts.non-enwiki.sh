#/bin/sh
cd /home/halfak/projects/gettingstarted && \
./daily_tagged_edits datasets/gs_wikis.non-enwiki.tsv "gettingstarted edit" --start-day=20140209 > \
datasets/daily_gettingstarted_edits.non-enwiki.tsv && \
cp datasets/daily_gettingstarted_edits.non-enwiki.tsv /a/public-datasets/all/gettingstarted/

