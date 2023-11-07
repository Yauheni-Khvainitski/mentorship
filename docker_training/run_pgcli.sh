#!/bin/bash
# Load environment variables
source postgres.env

# Use environment variables in pgcli command
pgcli -h localhost -p 5432 -U $POSTGRES_USER -d $POSTGRES_DB
