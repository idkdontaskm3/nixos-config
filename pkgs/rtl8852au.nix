{ stdenv, kernel, fetchFromGitHub, bc, pkg-config }:
stdenv.mkDerivation {
  pname = "rtl8852au";
  version = "unstable";
  src = fetchFromGitHub {
    owner = "pulponair";
    repo = "rtl8852au";
    rev = "main";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  
  nativeBuildInputs = [ bc pkg-config ];
  buildInputs = [ kernel.dev ];
  
  makeFlags = [ "KVER=${kernel.version}" "KSRC=${kernel.dev}/lib/modules/${kernel.version}/build" ];
  
  installPhase = ''
    install -Dm644 rtl8852au.ko $out/lib/modules/${kernel.version}/kernel/drivers/net/wireless/
  '';
};
