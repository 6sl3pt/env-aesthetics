#!/bin/bash

ai() {
  if [ -z "$AI_BASE_URL" ]; then
    echo -e "\033[0;31✘ ERROR: AI_BASE_URL is not set\033[0m"
    return 1
  fi

  if [ -z "$AI_API_KEY" ]; then
    echo -e "\033[0;31✘ ERROR: AI_API_KEY is not set\033[0m"
    return 1
  fi

  case "$1" in
  list)
    curl -s "$AI_BASE_URL/models" \
      -H "Authorization: Bearer $AI_API_KEY" |
      jq -r '.data[].id' |
      sed 's/^/• /'
    ;;

  ping)
    if [ -z "$2" ]; then
      echo "Usage: model ping <model-id>"
      return 1
    fi

    response=$(curl -s -w "%{http_code}" "$AI_BASE_URL/chat/completions" \
      -H "Authorization: Bearer $AI_API_KEY" \
      -H "Content-Type: application/json" \
      -d "{
          \"model\": \"$2\",
          \"messages\": [
            {\"role\": \"user\", \"content\": \"Hello\"}
          ],
          \"max_tokens\": 10000,
          \"temperature\": 0.1
        }")
    http_status="${response: -3}"
    body="${response:0:-3}"

    if [ "$http_status" -ge 400 ]; then
      echo -e "\033[0;31✘ HTTP Error $http_status\033[0m"
    fi

    content=$(echo "$body" | jq -r '.choices[0].message.content // "empty"' 2>/dev/null)
    echo -e "\033[0;32m✓ $content\033[0m"
    ;;

  *)
    echo "Usage:"
    echo "  ai list"
    echo "  ai ping <model-id>"
    ;;
  esac
}
