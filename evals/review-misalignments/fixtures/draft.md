# Data Platform Consolidation

## Current Architecture

The existing pipeline runs six nightly ETL jobs against three separate Oracle schemas, each on a distinct cron schedule (02:00, 02:45, and 03:30 local time).
Each job stages records into a 500MB rolling buffer before the merge step, and the merge step rebuilds four B-tree indexes sequentially because the current DDL does not support online index rebuilds on this Oracle version.

## Proposed Technical Changes

We will consolidate the three schemas into one, replace the sequential index rebuild with a partitioned rebuild strategy, and move the buffer size to 2GB to reduce the number of merge passes from four to one.
Query plans for the top twelve reporting views will need to be re-validated against the new partition scheme, and two materialized view logs will need to be dropped and recreated.

## Team Impact

This lets the data engineering team leverage the same schema for both the nightly batch and the new near-real-time feed, cutting the number of on-call pages roughly in half.

## Timeline and Cost

The migration is a six-week project estimated at $180,000, with the primary risk being a two-day read-only window during the schema cutover.
In short: this consolidation should reduce nightly job runtime by roughly 40% and cut on-call load in half, for a one-time cost of $180,000 over six weeks with one planned two-day read-only window.
