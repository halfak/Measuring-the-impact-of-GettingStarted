#/bin/sh
cd /home/halfak/projects/gettingstarted && \
./daily_tagged_edits datasets/gs_wikis.tsv "gettingstarted edit" > \
datasets/daily_gettingstarted_edits.tsv && \
cp datasets/daily_gettingstarted_edits.tsv /a/public-datasets/all/gettingstarted/

