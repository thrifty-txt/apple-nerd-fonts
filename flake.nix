{
  lib,
  stdenv,
  fetchFromGitHub,
}:

mkDerivation rec {
  pname = "source-sans";
  version = "3.052";

  src = fetchFromGitHub {
    owner = "gstand";
    repo = "apple-nerd-fonts";
    rev = "4eeb2b7ffab702de9a4718ca8266ebd830a5332b";
    hash = "";
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 OTF/*.otf -t $out/share/fonts/opentype
    install -Dm444 TTF/*.ttf -t $out/share/fonts/truetype
    install -Dm444 VF/*.otf -t $out/share/fonts/variable

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://adobe-fonts.github.io/source-sans/";
    description = "Sans serif font family for user interface environments";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ ttuegel ];
  };
}