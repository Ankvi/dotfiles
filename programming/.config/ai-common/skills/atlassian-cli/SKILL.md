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

## Assigning tickets to current user

Use command:

```bash
acli jira workitem assign --key {{ISSUE_KEY}} --assignee @me
```
