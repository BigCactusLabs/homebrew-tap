class DeadLetter < Formula
  include Language::Python::Virtualenv

  desc "Convert .eml email exports to Markdown with YAML front matter"
  homepage "https://github.com/BigCactusLabs/dead-letter"
  url "https://files.pythonhosted.org/packages/fd/84/a033d3d3d97362bdc4681ab0f8c55589baf5cce5ec855b868a143e4f5de7/dead_letter-0.2.5.tar.gz"
  sha256 "a87e12adf80df59cbb870dd4e9738c10bd87d9279bfe4016c27385921e13d28c"
  license "PolyForm-Noncommercial-1.0.0"

  depends_on arch: :arm64
  depends_on "python@3.14"

  preserve_rpath

  resource "html-to-markdown" do
    url "https://files.pythonhosted.org/packages/1f/32/bea823db133ad9b31a510a7ae9f24c8984c82be0d6ca1e1b973f018eaaa2/html_to_markdown-3.10.6-cp310-abi3-macosx_11_0_arm64.whl"
    sha256 "7603a3eb814d4be8e5e45ccad3d2461ba24a2ef60629fe500da3a030779d5c4b"
  end

  resource "icalendar" do
    url "https://files.pythonhosted.org/packages/bb/82/50bff78b0bb0c7d7c0cb39e0ee189b92f611fff6bd7cf57f25e92d5a7551/icalendar-7.3.0-py3-none-any.whl"
    sha256 "8355acfe17be81b368f0b1e3740817cea9b56ea889931f8f1a87c62f2d28db0b"
  end

  resource "mail-parser" do
    url "https://files.pythonhosted.org/packages/05/b2/db246a5f5e430e05ab358501cd34cfe2b422951a2738daf6054f4c2af885/mail_parser-4.6.3-py3-none-any.whl"
    sha256 "abfcba25955332c72d81c06aaf32107744fd70e610a6e50899efada542712afa"
  end

  resource "mail-parser-reply" do
    url "https://files.pythonhosted.org/packages/0f/5d/99bd9fb9556c54a66860ead493b9d9d77cc8d7a2c52aa76d995c50b73373/mail_parser_reply-1.36-py3-none-any.whl"
    sha256 "81395a4d8a0858509c875e6bbb7b004d53d70c7cd92204fe34a9926c55e4ef03"
  end

  resource "nh3" do
    url "https://files.pythonhosted.org/packages/f3/ab/a7653bce9a3b204be6a6931767a9e23595807bb84790ce6685e4d7e5bd08/nh3-0.3.6-cp38-abi3-macosx_10_12_x86_64.macosx_11_0_arm64.macosx_10_12_universal2.whl"
    sha256 "a43ebd7543555c3ac1bc353023d0794e75cb76f6f18f19c32e95441496c0cc25"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/bd/9c/4d95bb87eb2063d20db7b60faa3840c1b18025517ae857371c4dd55a6b3a/pyyaml-6.0.3-cp314-cp314-macosx_11_0_arm64.whl"
    sha256 "34d5fcd24b8445fadc33f9cf348c1047101756fd760b4dacb5c3e99755703310"
  end

  resource "selectolax" do
    url "https://files.pythonhosted.org/packages/12/fe/f4d7d554cd7db415c831c8fb5a2b6bbbe3bdf5a49c8f417a6093d4618d6c/selectolax-0.4.11-cp314-cp314-macosx_11_0_arm64.whl"
    sha256 "d5ce592a92fceeca2694b369a83ad72891a9c356f668718fe7e1c83eea407bb4"
  end

  resource "tzdata" do
    url "https://files.pythonhosted.org/packages/e5/6d/b53b99a9f2766d095985947a5782f1702cabb129a34f7a802d7197af832f/tzdata-2026.3-py2.py3-none-any.whl"
    sha256 "dc096730c87af6cab1b171c9d532be840741ff5d459015e7f6947bd7d7e54931"
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
