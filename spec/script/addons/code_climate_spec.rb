require 'spec_helper'

describe Travis::Build::Script::Addons::CodeClimate do
  let(:script) { stub_everything('script') }

  before(:each) { script.stubs(:fold).yields(script) }

  subject { described_class.new(script, config).before_script }

  context 'without credentials' do
    let(:config) { true }


  end

  context 'with a token' do
    let(:config) { { :token => '1234' } }

    it 'exports CODECLIMATE_REPO_TOKEN' do
      script.expects(:set).with('CODECLIMATE_REPO_TOKEN', '1234', echo: false, assert: false)
      subject
    end
  end

  context 'without a token' do
    let(:config) { {}}

    it "doesn't export CODECLIMATE_REPO_TOKEN" do
      script.expects(:set).with('CODECLIMATE_REPO_TOKEN', '1234', echo: false, assert: false).never
      subject
    end
  end
end