---
name: feature
description: Clarify and record the overall feature or change objective under .scalpel/change.md
disable-model-invocation: true
argument-hint: <describe the feature or change>
---

# Scalpel Feature

Interrogate the desired feature until it is unambiguous, then challenge the result before writing it down.

## Steps

### 1. Gather the Initial Description

Use `$ARGUMENTS` as the starting point. If no arguments were provided, ask the user to describe the feature before proceeding.

### 2. Grill the User

Ask targeted questions to eliminate ambiguity. Do not ask all questions at once — ask one or two at a time, wait for answers, then follow up. Keep going until you have clear answers to:

- **Scope**: What is explicitly in scope? What is explicitly out of scope?
- **Trigger**: What user action or system event initiates this?
- **Outcome**: What does success look like from the user's perspective?
- **Constraints**: Any technical, design, or business constraints that affect how it should be built?
- **Edge cases**: What should happen when things go wrong or inputs are unexpected?

Do not move to the next step until you could explain the feature to a new developer without them needing to ask a follow-up question.

### 3. Play Devil's Advocate

Before writing anything, challenge the description:

- **Necessity**: Is this feature actually needed, or does something existing already cover it?
- **Scope creep**: Is the description doing too much? Could it be split into a smaller first step?
- **Simplicity**: What is the simplest version of this that would still be valuable?
- **Assumptions**: What assumptions are baked in that might be wrong?

Present your challenges to the user and let them respond. Revise the description based on their answers.

### 4. Confirm and Write

Present the final description to the user and ask for explicit approval before writing. Then:

1. Create `.scalpel/` if it does not exist
2. Write the approved description to `.scalpel/change.md`:

```markdown
# Feature

<approved description>
```

3. Show the user the written file.

## Rules

- Do not write `.scalpel/change.md` until the user has approved the final description
- Do not implement anything
- Do not modify any source files
- Overwrite `.scalpel/change.md` if it already exists
