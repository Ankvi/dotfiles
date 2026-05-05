---
name: atlassian-cli
description: Use to read information from Jira tickets/issues when implementing a feature/fix/etc
---

# Skill for Atlassian CLI (acli)

Use to read information from Jira tickets/issues when implementing a feature/fix/etc

Command: `acli`

## Auth

Test authentication status:

```bash
acli auth status
```

## Reading tickets

Use command:

```bash
acli jira workitem view {{ISSUE_KEY}}
```

## Start working on a ticket

Whenever starting work on a Jira ticket,
use [start-ticket.sh script](./scripts/start-ticket.sh)

## Reading a Confluence page

Use when:

- A Confluence page is referenced a ticket
- The content of a Confluence page is requested

Use [read-confluence-page.sh script](./scripts/read-confluence-page.sh)

Pass Confluence page ID as the first argument

## Reading Confluence pages
