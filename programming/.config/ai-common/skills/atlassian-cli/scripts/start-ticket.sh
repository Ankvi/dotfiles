#!/usr/bin/env bash

echo "Assigning ticket $1 to ..."
acli jira workitem assign --key $1 --assignee @me

echo "Transitioning ticket $1 to 'In Progress'..."
acli jira workitem transition --key $1 --status "In Progress"

echo "Ticket $1 has been started and assigned to you."
