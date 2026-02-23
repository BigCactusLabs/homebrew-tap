cask "opentokeneater" do
  version "2.1.2"
  sha256 "a6a1e4bd576d33bc6fe7e7b42582f3c18edd7ad748c2271f67148ecf776707dd"

  url "https://github.com/BigCactusLabs/OpenTokenEater/releases/download/v#{version}/OpenTokenEater.dmg"
  name "OpenTokenEater"
  desc "Monitor Claude and OpenAI usage limits from macOS desktop"
  homepage "https://github.com/BigCactusLabs/OpenTokenEater"

  depends_on macos: ">= :sonoma"

  app "OpenTokenEater.app"
end
