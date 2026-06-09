class DeadLetter < Formula
  include Language::Python::Virtualenv

  desc "Convert .eml email exports to Markdown with YAML front matter"
  homepage "https://github.com/BigCactusLabs/dead-letter"
  url "https://files.pythonhosted.org/packages/67/2c/cd8e611f88dc1ad93c645d5dee200e8d57bde7f3fa2c875d8e301020ed20/dead_letter-0.2.3.tar.gz"
  sha256 "0639d9c881ee6140ba3ddcc9afaa618487a9149afb7e141ce61aefc91ceeb928"
  license "PolyForm-Noncommercial-1.0.0"

  depends_on arch: :arm64
  depends_on "python@3.14"

  preserve_rpath

  resource "html-to-markdown" do
    url "https://files.pythonhosted.org/packages/0e/ca/89fd1ad259591656517a86e702e18c348b145fbc8550708bed9c4325bb58/html_to_markdown-3.5.7-cp310-abi3-macosx_11_0_arm64.whl"
    sha256 "0c253e440864a01519031073a534b3838393f6aea6f88957bdf3546f3ee97325"
  end

  resource "icalendar" do
    url "https://files.pythonhosted.org/packages/7d/a0/2929543a1dfe2667e1ce08f2d6af59480d1467c0ee38acb94637965b3de3/icalendar-7.1.2-py3-none-any.whl"
    sha256 "01c76243c76c549f58bb51510a8f0a4edb7c539726adda1356dfd0dc04fb7a53"
  end

  resource "mail-parser" do
    url "https://files.pythonhosted.org/packages/8d/4f/38717202a3be94a37c262907adca700498fbb435a8356cfaed38387469c8/mail_parser-4.3.0-py3-none-any.whl"
    sha256 "e4092a15023b7075f4666f5040e2fca71fa35a7020753b7e90359c357ed3a099"
  end

  resource "mail-parser-reply" do
    url "https://files.pythonhosted.org/packages/0f/5d/99bd9fb9556c54a66860ead493b9d9d77cc8d7a2c52aa76d995c50b73373/mail_parser_reply-1.36-py3-none-any.whl"
    sha256 "81395a4d8a0858509c875e6bbb7b004d53d70c7cd92204fe34a9926c55e4ef03"
  end

  resource "nh3" do
    url "https://files.pythonhosted.org/packages/85/30/d162e99746a2fb1d98bb0ef23af3e201b156cf09f7de867c7390c8fe1c06/nh3-0.3.5-cp38-abi3-macosx_10_12_x86_64.macosx_11_0_arm64.macosx_10_12_universal2.whl"
    sha256 "3bb854485c9b33e5bb143ff3e49e577073bc6bc320f0ff8fc316dd89c0d3c101"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/bd/9c/4d95bb87eb2063d20db7b60faa3840c1b18025517ae857371c4dd55a6b3a/pyyaml-6.0.3-cp314-cp314-macosx_11_0_arm64.whl"
    sha256 "34d5fcd24b8445fadc33f9cf348c1047101756fd760b4dacb5c3e99755703310"
  end

  resource "selectolax" do
    url "https://files.pythonhosted.org/packages/df/a5/121f398a2ff01a5947b5601ed16f99e29771dbc21b23b18c8f4527f99a40/selectolax-0.4.10-cp314-cp314-macosx_11_0_arm64.whl"
    sha256 "01c1354b158f8c87b72ab50a12b4b6d7b276150ded39210d1078d65d1e24ae0d"
  end

  resource "tzdata" do
    url "https://files.pythonhosted.org/packages/ce/e4/dccd7f47c4b64213ac01ef921a1337ee6e30e8c6466046018326977efd95/tzdata-2026.2-py2.py3-none-any.whl"
    sha256 "bbe9af844f658da81a5f95019480da3a89415801f6cc966806612cc7169bffe7"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/ec/57/56b9bcc3c9c6a792fcbaf139543cee77261f3651ca9da0c93f5c1221264b/python_dateutil-2.9.0.post0-py2.py3-none-any.whl"
    sha256 "a8b2bc7bffae282281c8140a97d3aa9c14da0b136dfe83f850eea9a5f7470427"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/b7/ce/149a00dd41f10bc29e5921b496af8b574d8413afcd5e30dfa0ed46c2cc5e/six-1.17.0-py2.py3-none-any.whl"
    sha256 "4721f391ed90541fddacab5acf947aa0d3dc7d27b2e1e8eda2be8970586c3274"
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
