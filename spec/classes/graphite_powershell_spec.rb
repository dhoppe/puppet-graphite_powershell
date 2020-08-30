require 'spec_helper'

describe 'graphite_powershell' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      let :facts do
        facts
      end

      describe "graphite_powershell class without any parameters on #{os}" do
        let(:params) do
          {
            server: 'localhost'
          }
        end

        it { is_expected.to contain_class('graphite_powershell::params') }
        it { is_expected.to contain_class('graphite_powershell::config').that_comes_before('Class[graphite_powershell::install]') }
        it { is_expected.to contain_class('graphite_powershell::install').that_comes_before('Class[graphite_powershell::service]') }
        it { is_expected.to contain_class('graphite_powershell::service') }

        it { is_expected.to contain_service('GraphitePowerShell').that_subscribes_to('File[C:/GraphitePowershell/StatsToGraphiteConfig.xml]') }

        it { is_expected.to contain_file('C:/GraphitePowershell/Graphite-PowerShell.ps1').with_ensure('file') }

        it { is_expected.to contain_file('C:/GraphitePowershell/StatsToGraphiteConfig.xml').with_ensure('file') }
      end
    end
  end
end
