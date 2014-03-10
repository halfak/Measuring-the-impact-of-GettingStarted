#/bin/sh
cd /home/halfak/projects/gettingstarted && \
./daily_tagged_edits datasets/gs_wikis.enwiki.tsv "gettingstarted edit" > \
datasets/daily_gettingstarted_edits.enwiki.tsv && \
cp datasets/daily_gettingstarted_edits.enwiki.tsv /a/public-datasets/all/gettingstarted/

