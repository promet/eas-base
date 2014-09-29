normal['postfix']['main']['smtp_use_tls'] = 'yes'
normal['postfix']['main']['smtp_tls_CAfile'] = node['rsyslog']['tls_ca_file']
normal['postfix']['main']['smtp_tls_session_cache_database'] = 'btree:${data_directory}/smtp_scache'
