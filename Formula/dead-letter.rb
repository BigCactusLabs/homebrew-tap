class DeadLetter < Formula
  include Language::Python::Virtualenv

  desc "Convert .eml email exports to Markdown with YAML front matter"
  homepage "https://github.com/BigCactusLabs/dead-letter"
  url "https://files.pythonhosted.org/packages/8b/38/d7796db037d17424aa72d9901772cc7223653b5600b4ae61aa2efea730bd/dead_letter-0.4.5.tar.gz"
  version "0.4.5"
  sha256 "30ec52d5bd1435d6105641580b9f08b68341ebb37e0ebad4b4fa0ba18de60ab3"
  license "PolyForm-Noncommercial-1.0.0"

  depends_on arch: :arm64
  depends_on "libyaml"
  depends_on "python@3.14"

  preserve_rpath

  resource "html-to-markdown" do
    url "https://files.pythonhosted.org/packages/f9/91/abc3147cb40f52e5ca20b60b181a60bf8d156771660d79c9e4a74369c6f7/html_to_markdown-3.15.1-cp310-abi3-macosx_11_0_arm64.whl"
    sha256 "c4f0d58825b17fd4c225180b94ef62ce59c8ca79cbd21ddb14a13f23b34243be"
  end

  resource "icalendar" do
    url "https://files.pythonhosted.org/packages/bb/82/50bff78b0bb0c7d7c0cb39e0ee189b92f611fff6bd7cf57f25e92d5a7551/icalendar-7.3.0-py3-none-any.whl"
    sha256 "8355acfe17be81b368f0b1e3740817cea9b56ea889931f8f1a87c62f2d28db0b"
  end

  resource "mail-parser" do
    url "https://files.pythonhosted.org/packages/ca/a2/22afaa06dda1970ec5516600c172cc0fddd33986459876c5ff8f4b8fe068/mail_parser-4.6.5-py3-none-any.whl"
    sha256 "99ae29fb038d77a5e89a74366791ac3dbf2042244044c0390be403b6ede06765"
  end

  resource "mail-parser-reply" do
    url "https://files.pythonhosted.org/packages/0f/5d/99bd9fb9556c54a66860ead493b9d9d77cc8d7a2c52aa76d995c50b73373/mail_parser_reply-1.36-py3-none-any.whl"
    sha256 "81395a4d8a0858509c875e6bbb7b004d53d70c7cd92204fe34a9926c55e4ef03"
  end

  resource "nh3" do
    url "https://files.pythonhosted.org/packages/94/0d/c257754bf57f829f307aa226bbe136d3a1356b5a0d08324c7b6bd2a8aacd/nh3-0.3.7-cp38-abi3-macosx_10_12_x86_64.macosx_11_0_arm64.macosx_10_12_universal2.whl"
    sha256 "6c3aa50eb26e9228238271db9f983cbc3b006dfbfeca2d4dc34c33ddc6ac5ea5"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/ec/57/56b9bcc3c9c6a792fcbaf139543cee77261f3651ca9da0c93f5c1221264b/python_dateutil-2.9.0.post0-py2.py3-none-any.whl"
    sha256 "a8b2bc7bffae282281c8140a97d3aa9c14da0b136dfe83f850eea9a5f7470427"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/bd/9c/4d95bb87eb2063d20db7b60faa3840c1b18025517ae857371c4dd55a6b3a/pyyaml-6.0.3-cp314-cp314-macosx_11_0_arm64.whl"
    sha256 "34d5fcd24b8445fadc33f9cf348c1047101756fd760b4dacb5c3e99755703310"
  end

  resource "selectolax" do
    url "https://files.pythonhosted.org/packages/83/3b/98e192e76ef958527aaeb20cdd923ac99ec91fe84e577389bcfc35e8d63a/selectolax-0.4.13-cp314-cp314-macosx_11_0_arm64.whl"
    sha256 "b810c979aa06b98f04773c39cb93def57dfbb7bdcae642e741dd68082d07d4e1"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/b7/ce/149a00dd41f10bc29e5921b496af8b574d8413afcd5e30dfa0ed46c2cc5e/six-1.17.0-py2.py3-none-any.whl"
    sha256 "4721f391ed90541fddacab5acf947aa0d3dc7d27b2e1e8eda2be8970586c3274"
  end

  resource "tzdata" do
    url "https://files.pythonhosted.org/packages/f9/bc/8737e8d54cf51106118039b83f485a4783112fab49ea9d044b234978a46e/tzdata-2026.4-py2.py3-none-any.whl"
    sha256 "c2169a8b0a7a5e9674da5a135ccdfb2b3e671b333ed9fed17b41f73c34476e81"
  end

  def install
    venv = virtualenv_create(libexec, "python3.14")

    resources.each do |r|
      r.stage do
        venv.pip_install Dir["*.whl"].first || Pathname.pwd
      end
    end

    venv.pip_install_and_link buildpath

    rm bin/"dead-letter-mcp"
    rm bin/"dead-letter-ui"
  end

  test do
    assert_match "\"version\": \"#{version}\"", shell_output("#{bin}/dead-letter doctor --json")
    refute_path_exists bin/"dead-letter-mcp"
    refute_path_exists bin/"dead-letter-ui"
  end
end
