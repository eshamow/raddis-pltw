# supply a serverversion fact because chocolatey needs it and it's not set during apply

Facter.add(:serverversion) do
  setcode do
    # This will be nil if Puppet is not available.
    begin
      Module.const_get("Puppet")
    rescue NameError
      nil
    else
      Puppet.version
    end
  end
end
