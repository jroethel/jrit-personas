# Data Platform Consolidation

## Executive Summary

This consolidation will reduce nightly job runtime by roughly 40% and cut on-call load in half, for a one-time cost of $180,000 over six weeks with one planned two-day read-only window during cutover; approval is needed by end of month so the migration can start next quarter.

## Cost and Timeline

Six weeks, $180,000 total.
The only user-facing risk is a two-day read-only window while the schema cutover completes.

## Why Now

The team currently supports three separate schemas on three nightly schedules; consolidating them removes duplicate maintenance work and lets one team support both the nightly batch and an upcoming near-real-time feed with the same on-call rotation.

## Decision Needed

Approve the six-week timeline and the two-day read-only window by end of month so the migration can start next quarter.
