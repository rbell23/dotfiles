# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_vault_audit_global_optspecs
	string join \n h/help V/version
end

function __fish_vault_audit_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_vault_audit_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_vault_audit_using_subcommand
	set -l cmd (__fish_vault_audit_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c vault-audit -n "__fish_vault_audit_needs_command" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -s V -l version -d 'Print version'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "kv-analyzer" -d 'Analyze KV usage by path and entity (⚠️ DEPRECATED: Use \'kv-analysis analyze\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "kv-compare" -d 'Compare KV usage between two time periods (⚠️ DEPRECATED: Use \'kv-analysis compare\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "kv-summary" -d 'Summarize KV usage from CSV (⚠️ DEPRECATED: Use \'kv-analysis summary\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "system-overview" -d 'System overview - identify high-volume operations'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "token-operations" -d 'Analyze token operations by entity (⚠️ DEPRECATED: Use \'token-analysis\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "token-analysis" -d 'Unified token analysis - operations, abuse detection, and export'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "token-export" -d 'Export token lookup patterns to CSV (⚠️ DEPRECATED: Use \'token-analysis --export\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "token-lookup-abuse" -d 'Detect token lookup abuse patterns (⚠️ DEPRECATED: Use \'token-analysis --abuse-threshold\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "entity-analysis" -d 'Unified entity lifecycle analysis, creation tracking, and preprocessing'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "kv-analysis" -d 'Unified KV secrets analysis - usage, comparison, and summarization'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "entity-gaps" -d 'Analyze entity creation/deletion gaps (⚠️ DEPRECATED: Use \'entity-analysis gaps\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "entity-timeline" -d 'Show timeline of operations for a specific entity (⚠️ DEPRECATED: Use \'entity-analysis timeline\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "path-hotspots" -d 'Identify path access hotspots'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "k8s-auth" -d 'Analyze Kubernetes auth patterns and entity churn'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "airflow-polling" -d 'Analyze Airflow polling patterns'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "preprocess-entities" -d 'Preprocess audit logs to extract entity mappings (⚠️ DEPRECATED: Use \'entity-analysis preprocess\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "entity-creation" -d 'Analyze entity creation by authentication path (⚠️ DEPRECATED: Use \'entity-analysis creation\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "entity-churn" -d 'Multi-day entity churn analysis with intelligent ephemeral pattern detection (⚠️ DEPRECATED: Use \'entity-analysis churn\' instead)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "client-activity" -d 'Get Vault client activity by mount (queries Vault API)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "client-traffic-analysis" -d 'Analyze client traffic patterns from aggregated audit logs'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "entity-list" -d 'List Vault entities and aliases (queries Vault API)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "kv-mounts" -d 'List KV v2 mounts (queries Vault API)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "auth-mounts" -d 'List authentication mounts (queries Vault API)'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "generate-completion" -d 'Generate shell completion scripts'
complete -c vault-audit -n "__fish_vault_audit_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analyzer" -l kv-prefix -d 'KV mount prefix to filter (e.g., "kv/", leave empty for all KV mounts)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analyzer" -s o -l output -d 'Output CSV file path' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analyzer" -l entity-csv -d 'Entity alias CSV for enrichment (columns: `entity_id`, name)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analyzer" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-compare" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-summary" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand system-overview" -l top -d 'Number of top operations to show' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand system-overview" -l min-operations -d 'Minimum operations to report' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand system-overview" -l namespace-filter -d 'Filter by namespace ID (e.g., "root")' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand system-overview" -l sequential -d 'Process files sequentially instead of in parallel (for debugging)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand system-overview" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-operations" -s o -l output -d 'Output CSV file path' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-operations" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-analysis" -l abuse-threshold -d 'Detect token lookup abuse - show entities exceeding this threshold' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-analysis" -l filter -d 'Filter by operation type (comma-separated: lookup, create, renew, revoke, login)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-analysis" -l export -d 'Export data to CSV file' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-analysis" -l min-operations -d 'Minimum operations to include in export' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-analysis" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-export" -s o -l output -d 'Output CSV file' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-export" -l min-lookups -d 'Minimum lookups to include' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-export" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-lookup-abuse" -l threshold -d 'Minimum lookups to flag as suspicious' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand token-lookup-abuse" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and not __fish_seen_subcommand_from churn creation preprocess gaps timeline help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and not __fish_seen_subcommand_from churn creation preprocess gaps timeline help" -f -a "churn" -d 'Multi-day entity churn analysis with ephemeral pattern detection'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and not __fish_seen_subcommand_from churn creation preprocess gaps timeline help" -f -a "creation" -d 'Analyze entity creation by authentication path'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and not __fish_seen_subcommand_from churn creation preprocess gaps timeline help" -f -a "preprocess" -d 'Extract entity mappings from audit logs'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and not __fish_seen_subcommand_from churn creation preprocess gaps timeline help" -f -a "gaps" -d 'Detect activity gaps for entities'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and not __fish_seen_subcommand_from churn creation preprocess gaps timeline help" -f -a "timeline" -d 'Show timeline of operations for a specific entity'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and not __fish_seen_subcommand_from churn creation preprocess gaps timeline help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from churn" -l entity-map -d 'Optional entity mappings JSON file (auto-generated if not provided)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from churn" -l baseline -d 'Baseline entity list JSON to identify pre-existing entities' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from churn" -s o -l output -d 'Output file path for detailed churn data' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from churn" -l format -d 'Output format: json or csv' -r -f -a "json\t''
csv\t''"
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from churn" -l no-auto-preprocess -d 'Disable automatic entity preprocessing'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from churn" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from creation" -l entity-map -d 'Optional entity mappings JSON file (auto-generated if not provided)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from creation" -s o -l output -d 'Output JSON file path for detailed creation data' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from creation" -l no-auto-preprocess -d 'Disable automatic entity preprocessing'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from creation" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from preprocess" -s o -l output -d 'Output file path' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from preprocess" -l format -d 'Output format: json or csv' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from preprocess" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from gaps" -l window-seconds -d 'Time window in seconds for gap detection' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from gaps" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from timeline" -l entity-id -d 'Entity ID to analyze' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from timeline" -l display-name -d 'Display name (optional)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from timeline" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from help" -f -a "churn" -d 'Multi-day entity churn analysis with ephemeral pattern detection'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from help" -f -a "creation" -d 'Analyze entity creation by authentication path'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from help" -f -a "preprocess" -d 'Extract entity mappings from audit logs'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from help" -f -a "gaps" -d 'Detect activity gaps for entities'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from help" -f -a "timeline" -d 'Show timeline of operations for a specific entity'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-analysis; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and not __fish_seen_subcommand_from analyze compare summary help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and not __fish_seen_subcommand_from analyze compare summary help" -f -a "analyze" -d 'Comprehensive KV usage analysis from audit logs'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and not __fish_seen_subcommand_from analyze compare summary help" -f -a "compare" -d 'Compare KV usage between two time periods'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and not __fish_seen_subcommand_from analyze compare summary help" -f -a "summary" -d 'Summarize KV usage from CSV export'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and not __fish_seen_subcommand_from analyze compare summary help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and __fish_seen_subcommand_from analyze" -l kv-prefix -d 'KV mount prefix to filter (e.g., "kv/", leave empty for all KV mounts)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and __fish_seen_subcommand_from analyze" -s o -l output -d 'Output CSV file path' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and __fish_seen_subcommand_from analyze" -l entity-csv -d 'Entity alias CSV for enrichment (columns: `entity_id`, name)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and __fish_seen_subcommand_from analyze" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and __fish_seen_subcommand_from compare" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and __fish_seen_subcommand_from summary" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and __fish_seen_subcommand_from help" -f -a "analyze" -d 'Comprehensive KV usage analysis from audit logs'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and __fish_seen_subcommand_from help" -f -a "compare" -d 'Compare KV usage between two time periods'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and __fish_seen_subcommand_from help" -f -a "summary" -d 'Summarize KV usage from CSV export'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-analysis; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-gaps" -l window-seconds -d 'Time window in seconds for gap detection' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-gaps" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-timeline" -l entity-id -d 'Entity ID to analyze' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-timeline" -l display-name -d 'Display name (optional)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-timeline" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand path-hotspots" -l top -d 'Number of top paths to show' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand path-hotspots" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand k8s-auth" -s o -l output -d 'Output CSV file for service account analysis' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand k8s-auth" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand airflow-polling" -l path-pattern -d 'Path pattern to analyze (e.g., "airflow")' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand airflow-polling" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand preprocess-entities" -s o -l output -d 'Output file path' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand preprocess-entities" -l format -d 'Output format: csv or json' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand preprocess-entities" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-creation" -l entity-map -d 'Optional entity mappings JSON file for display name enrichment' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-creation" -s o -l output -d 'Output JSON file path for detailed entity creation data' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-creation" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-churn" -l entity-map -d 'Optional entity mappings JSON file for display name enrichment' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-churn" -l baseline -d 'Baseline entity list JSON (from entity-list command) to identify pre-existing entities' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-churn" -s o -l output -d 'Output file path for detailed entity churn data with ephemeral analysis' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-churn" -l format -d 'Output format: json or csv (auto-detected from file extension if not specified)' -r -f -a "json\t''
csv\t''"
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-churn" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-activity" -l start -d 'Start time in RFC3339 UTC format (e.g., 2025-10-01T00:00:00Z)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-activity" -l end -d 'End time in RFC3339 UTC format (e.g., 2025-11-01T00:00:00Z)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-activity" -l vault-addr -d 'Vault address (default: $`VAULT_ADDR` or <http://127.0.0.1:8200>)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-activity" -l vault-token -d 'Vault token (default: $`VAULT_TOKEN` or $`VAULT_TOKEN_FILE`)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-activity" -l vault-namespace -d 'Vault namespace (default: $`VAULT_NAMESPACE`)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-activity" -l entity-map -d 'Path to entity mappings JSON file (for Vault 1.16 compatibility)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-activity" -s o -l output -d 'Output CSV file path' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-activity" -l insecure -d 'Skip TLS certificate verification (insecure)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-activity" -l group-by-role -d 'Group by role/appcode within each mount (uses `entity_alias_name`)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-activity" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -s o -l output -d 'Output file path for summary client metrics (CSV or JSON)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -l format -d 'Output format: json or csv (auto-detected from file extension if not specified)' -r -f -a "json\t''
csv\t''"
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -l error-details-output -d 'Output file path for detailed error analysis with entity information (CSV)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -l top -d 'Number of top clients to show in summary (default: 20)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -l min-requests -d 'Minimum requests threshold for client classification (default: 100)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -l temporal -d 'Enable temporal analysis (hourly request patterns)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -l show-operations -d 'Show operation type breakdown per client'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -l show-errors -d 'Show error details and patterns'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -l show-details -d 'Show detailed per-client analysis (paths, entities, mount points)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -s v -l verbose -d 'Show all available information (equivalent to --show-operations --show-errors --show-details)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand client-traffic-analysis" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-list" -l vault-addr -d 'Vault address (default: $`VAULT_ADDR` or <http://127.0.0.1:8200>)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-list" -l vault-token -d 'Vault token (default: $`VAULT_TOKEN` or $`VAULT_TOKEN_FILE`)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-list" -l vault-namespace -d 'Vault namespace (default: $`VAULT_NAMESPACE`)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-list" -s o -l output -d 'Output file path' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-list" -l format -d 'Output format: csv or json' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-list" -s m -l mount -d 'Filter by specific mount path (e.g., "auth/kubernetes/")' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-list" -l insecure -d 'Skip TLS certificate verification (insecure)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand entity-list" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-mounts" -l vault-addr -d 'Vault address (default: $`VAULT_ADDR` or <http://127.0.0.1:8200>)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-mounts" -l vault-token -d 'Vault token (default: $`VAULT_TOKEN` or $`VAULT_TOKEN_FILE`)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-mounts" -l vault-namespace -d 'Vault namespace (default: $`VAULT_NAMESPACE`)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-mounts" -s o -l output -d 'Output file path' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-mounts" -l format -d 'Output format: csv (default), json, or stdout' -r -f -a "csv\t''
json\t''
stdout\t''"
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-mounts" -s d -l depth -d 'Maximum depth to traverse within KV mounts (default: unlimited, 0 = mounts only, 1 = one level, etc.)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-mounts" -l insecure -d 'Skip TLS certificate verification (insecure)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand kv-mounts" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand auth-mounts" -l vault-addr -d 'Vault address (default: $`VAULT_ADDR` or <http://127.0.0.1:8200>)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand auth-mounts" -l vault-token -d 'Vault token (default: $`VAULT_TOKEN` or $`VAULT_TOKEN_FILE`)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand auth-mounts" -l vault-namespace -d 'Vault namespace (default: $`VAULT_NAMESPACE`)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand auth-mounts" -s o -l output -d 'Output file path' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand auth-mounts" -l format -d 'Output format: csv (default), json, or stdout' -r -f -a "csv\t''
json\t''
stdout\t''"
complete -c vault-audit -n "__fish_vault_audit_using_subcommand auth-mounts" -l depth -d 'Maximum depth to traverse within auth mounts (default: unlimited, 0 = mounts only, 1 = include roles/users)' -r
complete -c vault-audit -n "__fish_vault_audit_using_subcommand auth-mounts" -l insecure -d 'Skip TLS certificate verification (insecure)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand auth-mounts" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand generate-completion" -s h -l help -d 'Print help'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "kv-analyzer" -d 'Analyze KV usage by path and entity (⚠️ DEPRECATED: Use \'kv-analysis analyze\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "kv-compare" -d 'Compare KV usage between two time periods (⚠️ DEPRECATED: Use \'kv-analysis compare\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "kv-summary" -d 'Summarize KV usage from CSV (⚠️ DEPRECATED: Use \'kv-analysis summary\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "system-overview" -d 'System overview - identify high-volume operations'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "token-operations" -d 'Analyze token operations by entity (⚠️ DEPRECATED: Use \'token-analysis\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "token-analysis" -d 'Unified token analysis - operations, abuse detection, and export'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "token-export" -d 'Export token lookup patterns to CSV (⚠️ DEPRECATED: Use \'token-analysis --export\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "token-lookup-abuse" -d 'Detect token lookup abuse patterns (⚠️ DEPRECATED: Use \'token-analysis --abuse-threshold\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "entity-analysis" -d 'Unified entity lifecycle analysis, creation tracking, and preprocessing'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "kv-analysis" -d 'Unified KV secrets analysis - usage, comparison, and summarization'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "entity-gaps" -d 'Analyze entity creation/deletion gaps (⚠️ DEPRECATED: Use \'entity-analysis gaps\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "entity-timeline" -d 'Show timeline of operations for a specific entity (⚠️ DEPRECATED: Use \'entity-analysis timeline\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "path-hotspots" -d 'Identify path access hotspots'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "k8s-auth" -d 'Analyze Kubernetes auth patterns and entity churn'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "airflow-polling" -d 'Analyze Airflow polling patterns'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "preprocess-entities" -d 'Preprocess audit logs to extract entity mappings (⚠️ DEPRECATED: Use \'entity-analysis preprocess\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "entity-creation" -d 'Analyze entity creation by authentication path (⚠️ DEPRECATED: Use \'entity-analysis creation\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "entity-churn" -d 'Multi-day entity churn analysis with intelligent ephemeral pattern detection (⚠️ DEPRECATED: Use \'entity-analysis churn\' instead)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "client-activity" -d 'Get Vault client activity by mount (queries Vault API)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "client-traffic-analysis" -d 'Analyze client traffic patterns from aggregated audit logs'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "entity-list" -d 'List Vault entities and aliases (queries Vault API)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "kv-mounts" -d 'List KV v2 mounts (queries Vault API)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "auth-mounts" -d 'List authentication mounts (queries Vault API)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "generate-completion" -d 'Generate shell completion scripts'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and not __fish_seen_subcommand_from kv-analyzer kv-compare kv-summary system-overview token-operations token-analysis token-export token-lookup-abuse entity-analysis kv-analysis entity-gaps entity-timeline path-hotspots k8s-auth airflow-polling preprocess-entities entity-creation entity-churn client-activity client-traffic-analysis entity-list kv-mounts auth-mounts generate-completion help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and __fish_seen_subcommand_from entity-analysis" -f -a "churn" -d 'Multi-day entity churn analysis with ephemeral pattern detection'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and __fish_seen_subcommand_from entity-analysis" -f -a "creation" -d 'Analyze entity creation by authentication path'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and __fish_seen_subcommand_from entity-analysis" -f -a "preprocess" -d 'Extract entity mappings from audit logs'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and __fish_seen_subcommand_from entity-analysis" -f -a "gaps" -d 'Detect activity gaps for entities'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and __fish_seen_subcommand_from entity-analysis" -f -a "timeline" -d 'Show timeline of operations for a specific entity'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and __fish_seen_subcommand_from kv-analysis" -f -a "analyze" -d 'Comprehensive KV usage analysis from audit logs'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and __fish_seen_subcommand_from kv-analysis" -f -a "compare" -d 'Compare KV usage between two time periods'
complete -c vault-audit -n "__fish_vault_audit_using_subcommand help; and __fish_seen_subcommand_from kv-analysis" -f -a "summary" -d 'Summarize KV usage from CSV export'
