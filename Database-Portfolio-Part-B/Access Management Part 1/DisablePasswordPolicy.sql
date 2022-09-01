
-- checking status 
select plugin_name, plugin_status from information_schema.plugins where plugin_name like 'validate%';

-- enabling enforce password policy 
install plugin validate_password soname 'validate_password.dll';

-- disabling enforce password policy
uninstall plugin validate_password;





