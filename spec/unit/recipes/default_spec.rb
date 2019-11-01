#
# Cookbook:: mangodb_new1
# Spec:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mangodb_new1::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '16.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it "Should test for updates" do
      expect(chef_run).to update_apt_update "update_sources"
    end

    it "Should test for the correct mongod-org repository" do
      expect(chef_run).to add_apt_repository "mongodb-org"
    end

    it "should install mongodb using a recipe" do
      expect(chef_run).to install_package 'mongodb-org'
    end

    it "should enable service mongodb" do
      expect(chef_run).to enable_service 'mongod'
    end

    it "should start service mongodb" do
      expect(chef_run).to start_service 'mongod'
    end

    it "should create mongod.conf" do
      expect(chef_run).to create_template("/etc/mongod.conf").with_variables(port_number: 27017)
    end

    it "should create a mongod.service.erb" do
      expect(chef_run).to create_template "/lib/systemd/system/mongod.service"
    end

  end
end
