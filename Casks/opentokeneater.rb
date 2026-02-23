cask "opentokeneater" do
  version :latest
  sha256 :no_check

  url "https://github.com/BigCactusLabs/OpenTokenEater/releases/latest/download/OpenTokenEater.dmg"
  name "OpenTokenEater"
  desc "Monitor Claude and OpenAI usage limits from macOS desktop"
  homepage "https://github.com/BigCactusLabs/OpenTokenEater"

  depends_on macos: ">= :sonoma"

  app "OpenTokenEater.app"
end
