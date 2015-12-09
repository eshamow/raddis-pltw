class pltw::windows (
  $hostname_mapping = {},
) {

  local_security_policy { 'Maximum password age':
    ensure         => present,
    policy_setting => 'MaximumPasswordAge',
    policy_type    => 'System Access',
    policy_value   => '0',
  }

  local_security_policy { 'Password must meet complexity requirements':
    ensure         => present,
    policy_setting => 'PasswordComplexity',
    policy_type    => 'System Access',
    policy_value   => '0',
  }

  local_security_policy { 'Minimum password length':
    ensure         => present,
    policy_setting => 'MinimumPasswordLength',
    policy_type    => 'System Access',
    policy_value   => '6',
  }

  if $hostname_mapping[$::hostname] {
    user { $hostname_mapping[$::hostname]:
      ensure   => present,
      password => 'beh217',
      require  => [
        Local_security_policy['Maximum password age'],
        Local_security_policy['Password must meet complexity requirements'],
        Local_security_policy['Minimum password length'],
      ],
    }
  }

}
