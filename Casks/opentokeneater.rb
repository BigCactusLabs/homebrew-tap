cask "opentokeneater" do
  version "2.1.5"
  sha256 "a89d075cf814e622157d9a04a712f455f1205ba3c6f6dada76dd4f886911b63c"

  url "https://github.com/BigCactusLabs/OpenTokenEater/releases/download/v#{version}/OpenTokenEater.dmg"
  name "OpenTokenEater"
  desc "Monitor Claude and OpenAI usage limits from macOS desktop"
  homepage "https://github.com/BigCactusLabs/OpenTokenEater"

  depends_on macos: ">= :sonoma"

  app "OpenTokenEater.app"
end
