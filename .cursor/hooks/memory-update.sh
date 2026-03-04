#!/bin/bash
# Memory update hook -- fires when the agent finishes a turn.
# If this is the first stop (loop_count 0) and the agent completed
# successfully, ask it to check whether memory.mdc needs updating.

INPUT=$(cat)

LOOP_COUNT=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('loop_count', 0))
except:
    print('0')
" 2>/dev/null)

STATUS=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('status', ''))
except:
    print('')
" 2>/dev/null)

if [ "$LOOP_COUNT" = "0" ] && [ "$STATUS" = "completed" ]; then
    cat << 'EOF'
{"followup_message": "[Memory check] If you made meaningful changes this turn (created/edited files, wrote code, made decisions, changed project direction), silently update .cursor/rules/memory.mdc to reflect the current state. Keep it under 15 lines in the State/Context sections. Update the 'Updated' date. If nothing significant happened, skip this entirely and say nothing."}
EOF
else
    echo '{}'
fi
