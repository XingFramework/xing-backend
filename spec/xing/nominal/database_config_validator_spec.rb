require 'spec_helper'
require 'xing/nominal/database_config_validator'

describe Xing::Nominal::DatabaseConfigValidator do

  before do
    expect(File).to receive(:open).and_return(nil)
  end

  let :dev_yaml do
    YAML.load(DEV_FIXTURE)
  end

  let :prod_yaml do
    YAML.load(PROD_FIXTURE)
  end

  it "when development has a missing key" do
    expect(YAML).to receive(:load).and_return(dev_yaml.deep_merge({'development' => { 'database' => nil }}))
    validator = Xing::Nominal::DatabaseConfigValidator.new
    validator.validate('development')
    expect(validator.errors['development']).not_to be_blank
    expect(validator.errors['test']).to            be_blank
  end

  it "succeeds when development has no missing keys" do
    expect(YAML).to receive(:load).and_return(dev_yaml)
    validator = Xing::Nominal::DatabaseConfigValidator.new
    validator.validate('development')
    expect(validator.errors['development']).to be_blank
    expect(validator.errors['test']).to        be_blank
  end

  it "when development has a missing key and test has a misformatted value " do
    expect(YAML).to receive(:load).and_return(dev_yaml.deep_merge({
      'development' => { 'adapter'  => nil  },
      'test'        => { 'database' => 1000 }})
    )
    validator = Xing::Nominal::DatabaseConfigValidator.new
    validator.validate('development')
    expect(validator.errors['development']['adapter']).not_to be_blank
    expect(validator.errors['test']['database']).not_to       be_blank
  end

  context "production" do
    it "succeeds when all values are present" do
      expect(YAML).to receive(:load).and_return(prod_yaml)
      validator = Xing::Nominal::DatabaseConfigValidator.new
      validator.validate('production')
      expect(validator.errors).to be_blank
    end

    it "requires username" do
      expect(YAML).to receive(:load).and_return(prod_yaml.deep_merge({'production' => { 'username' => nil }}))
      validator = Xing::Nominal::DatabaseConfigValidator.new
      validator.validate('production')
      expect(validator.errors['production']['username']).not_to be_blank
    end

    it "requires password" do
      expect(YAML).to receive(:load).and_return(prod_yaml.deep_merge({'production' => { 'password' => nil }}))
      validator = Xing::Nominal::DatabaseConfigValidator.new
      validator.validate('production')
      expect(validator.errors['production']['password']).not_to be_blank
    end

    it "requires host" do
      expect(YAML).to receive(:load).and_return(prod_yaml.deep_merge({'production' => { 'host' => nil }}))
      validator = Xing::Nominal::DatabaseConfigValidator.new
      validator.validate('production')
      expect(validator.errors['production']['host']).not_to be_blank
    end
  end


  DEV_FIXTURE = <<EOS
development:
  adapter: postgresql
  encoding: unicode
  database: cms2_dev

test:
  adapter: postgresql
  encoding: unicode
  database: cms2_dev
EOS

  PROD_FIXTURE = <<EOS

production:
  adapter: postgresql
  encoding: unicode
  database: cms2_dev
  username: a_user
  password: abcdef
  host: 127.0.0.1
EOS

end
