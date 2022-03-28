# InSpec test for hab_sup_service Chef Habitat package

control 'service checks' do
  impact 0.1
  title 'Check for creation of service.'
  # http://inspec.io/docs/reference/resources/systemd_service/
  describe.one do
    describe systemd_service('hab-sup') do
      it { should be_installed }
      it { should be_enabled }
    end
    describe service('hab-sup') do
      it { should be_installed }
      it { should be_enabled }
    end
  end
end

control 'supervisor config toml' do
  impact 0.1
  title 'Verify that Habitat Supervisor config toml is present'
  # http://inspec.io/docs/reference/resources/file/
  describe file('/hab/sup/default/config/sup.toml') do
    it { should exist }
  end
end
