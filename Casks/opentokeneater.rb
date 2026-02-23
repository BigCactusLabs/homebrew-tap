cask "opentokeneater" do
  version "2.1.4"
  sha256 "f2e17ec2ff5b6448b8b5056a229bc527e6c7075d037715b78f93eecf35ac2dc5"

  url "https://github.com/BigCactusLabs/OpenTokenEater/releases/download/v#{version}/OpenTokenEater.dmg"
  name "OpenTokenEater"
  desc "Monitor Claude and OpenAI usage limits from macOS desktop"
  homepage "https://github.com/BigCactusLabs/OpenTokenEater"

  depends_on macos: ">= :sonoma"

  app "OpenTokenEater.app"
end
