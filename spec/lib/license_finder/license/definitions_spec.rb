# frozen_string_literal: true

require 'spec_helper'

describe LicenseFinder::License::Definitions do
  it 'should create unrecognized licenses' do
    license = described_class.build_unrecognized('foo')
    expect(license.name).to eq('foo')
    expect(license.url).to be_nil
    expect(license).to be_matches_name('foo')
    expect(license).not_to be_matches_text('foo')
  end
end

describe LicenseFinder::License, 'Apache2' do
  it 'should be recognized' do |_e|
    expect(described_class.find_by_name('Apache2').url).to be
  end
end

describe LicenseFinder::License, 'BSD' do
  it 'should be recognized' do |_e|
    expect(described_class.find_by_name('BSD').url).to be
  end
end

describe LicenseFinder::License, 'cc01' do
  it 'should be recognized' do |_e|
    expect(described_class.find_by_name('CC0 1.0').url).to be
  end
end

describe LicenseFinder::License, 'GPLv2' do
  it 'should be recognized' do
    expect(described_class.find_by_name('GPLv2').url).to be
  end
end

describe LicenseFinder::License, 'GPLv3' do
  it 'should be recognized' do
    expect(described_class.find_by_name('GPLv3').url).to be
  end
end

describe LicenseFinder::License, 'ISC' do
  it 'should be recognized' do
    expect(described_class.find_by_name('ISC').url).to be
  end
end

describe LicenseFinder::License, 'LGPL' do
  it 'should be recognized' do
    expect(described_class.find_by_name('LGPL').url).to be
  end
end

describe LicenseFinder::License, 'MIT' do
  subject { described_class.find_by_name 'MIT' }

  describe '#matches_text?' do
    it 'should return true if the text contains the MIT url' do
      expect(subject).to be_matches_text 'MIT License is awesome http://opensource.org/licenses/mit-license'

      expect(subject).to be_matches_text 'MIT Licence is awesome http://www.opensource.org/licenses/mit-license'

      expect(subject).not_to be_matches_text 'MIT Licence is awesome http://www!opensource!org/licenses/mit-license'
    end

    it "should return true if the text begins with 'The MIT License'" do
      expect(subject).to be_matches_text 'The MIT License'

      expect(subject).to be_matches_text 'The MIT Licence'

      expect(subject).not_to be_matches_text "Something else\nThe MIT License"
    end

    it "should return true if the text contains 'is released under the MIT license'" do
      expect(subject).to be_matches_text 'is released under the MIT license'

      expect(subject).to be_matches_text 'is released under the MIT licence'
    end
  end
end

describe LicenseFinder::License, 'MPL1_1' do
  subject { described_class.find_by_name 'MPL1_1' }

  it 'should be recognized' do
    expect(subject).to be
  end

  describe '#matches_text?' do
    it "should return true if the text begins with 'Mozilla Public License Version 1.1'" do
      expect(subject).to be_matches_text 'Mozilla Public License Version 1.1'
    end

    it "should return false if the text beings with 'Mozilla Public License, version 2.0'" do
      expect(subject).not_to be_matches_text 'Mozilla Public License, version 2.0'
    end
  end
end

describe LicenseFinder::License, 'MPL2' do
  subject { described_class.find_by_name 'MPL2' }

  describe '#matches_text?' do
    it "should return true if the text begins with 'The Mozilla Public License, version 2.0'" do
      expect(subject).to be_matches_text 'Mozilla Public License, version 2.0'

      expect(subject).not_to be_matches_text "Something else\nMozilla Public License, version 2.0"
    end
  end
end

describe LicenseFinder::License, 'NewBSD' do
  subject { described_class.find_by_name 'NewBSD' }

  it 'should match regardless of organization or copyright holder names' do
    license = <<-LICENSE
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Johnny %$#!.43298432, Guitar INC! nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Johnny %$#!.43298432, Guitar BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    LICENSE

    expect(subject).to be_matches_text license
  end

  it 'should match with the alternate wording of third clause' do
    license = <<-LICENSE
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * The names of its contributors may not be used to endorse or promote
      products derived from this software without specific prior written
      permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Johnny %$#!.43298432, Guitar BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    LICENSE

    expect(subject).to be_matches_text license
  end
end

describe LicenseFinder::License, 'OFL' do
  it 'should be recognized' do
    expect(described_class.find_by_name('OFL').url).to be
  end
end

describe LicenseFinder::License, 'Python' do
  it 'should be recognized' do
    expect(described_class.find_by_name('Python').url).to be
  end
end

describe LicenseFinder::License, 'Ruby' do
  subject { described_class.find_by_name 'Ruby' }

  describe '#matches?' do
    it 'should return true when the Ruby license URL is present' do
      expect(subject).to be_matches_text "This gem is available under the following license:\nhttp://www.ruby-lang.org/en/LICENSE.txt\nOkay?"
    end

    it 'should return false when the Ruby License URL is not present' do
      expect(subject).not_to be_matches_text "This gem is available under the following license:\nhttp://www.example.com\nOkay?"
    end

    it 'should return false for pathological licenses' do
      expect(subject).not_to be_matches_text "This gem is available under the following license:\nhttp://wwwzruby-langzorg/en/LICENSEztxt\nOkay?"
    end
  end
end

describe LicenseFinder::License, 'SimplifiedBSD' do
  it 'should be recognized' do
    expect(described_class.find_by_name('SimplifiedBSD').url).to be
  end
end

describe LicenseFinder::License, 'Unlicense' do
  it 'should be recognized' do
    expect(described_class.find_by_name('Unlicense').name).to eq('The Unlicense')
    expect(described_class.find_by_name('Unlicense').url).to be
  end
end

describe LicenseFinder::License, 'WTFPL' do
  it 'should be recognized' do
    expect(described_class.find_by_name('WTFPL').name).to eq('WTFPL')
    expect(described_class.find_by_name('WTFPL').url).to be
    expect(described_class.find_by_name('WTFPL V2').url).to be
    expect(described_class.find_by_name('Do What The Fuck You Want To Public License').url).to be
  end
end

describe LicenseFinder::License, '0BSD' do
  it 'should be recognized' do
    expect(described_class.find_by_name('0BSD').url).to be
    expect(described_class.find_by_name('Zero-Clause BSD').url).to be
  end
end

describe LicenseFinder::License, 'Zlib' do
  it 'should be recognized' do
    expect(described_class.find_by_name('Zlib').url).to be
    expect(described_class.find_by_name('zlib/libpng license').url).to be
    expect(described_class.find_by_name('zlib License').url).to be
  end

  it 'should match regardless of year or copyright holder names' do
    license = <<-LICENSE
SOFTWARE NAME - Copyright (c) 1995-2017 - COPYRIGHT HOLDER NAME

This software is provided 'as-is', without any express or
implied warranty. In no event will the authors be held
liable for any damages arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute
it freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented;
   you must not claim that you wrote the original software.
   If you use this software in a product, an acknowledgment
   in the product documentation would be appreciated but
   is not required.

2. Altered source versions must be plainly marked as such,
   and must not be misrepresented as being the original software.

3. This notice may not be removed or altered from any
   source distribution.
    LICENSE

    expect(described_class.find_by_name('Zlib')).to be_matches_text license
    expect(described_class.find_by_name('Zlib')).not_to be_matches_text 'SOME OTHER LICENSE'
  end
end
