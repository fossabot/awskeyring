require 'spec_helper'

describe Awskeyring do
  context 'When there is no config file' do
    before do
      allow(File).to receive(:exist?).and_call_original
      allow(File).to receive(:exist?)
        .with(/\.awskeyring/)
        .and_return(false)
    end

    it 'has a version number' do
      expect(Awskeyring::VERSION).not_to be nil
    end

    it 'has a default preferences file' do
      expect(Awskeyring::PREFS_FILE).not_to be nil
    end

    it 'can not load preferences' do
      expect(subject.prefs).to eq({})
    end
  end

  context 'When there is a config file' do
    before do
      allow(File).to receive(:exist?).and_call_original
      allow(File).to receive(:exist?)
        .with(/\.awskeyring/)
        .and_return(true)
      allow(File).to receive(:read).and_call_original
      allow(File).to receive(:read)
        .with(/\.awskeyring/)
        .and_return('{ "awskeyring": "test" }')
    end

    it 'loads preferences from a file' do
      expect(subject.prefs).to eq('awskeyring' => 'test')
    end
  end
end
