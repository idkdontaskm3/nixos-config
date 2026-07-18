{ stdenv, kernel, fetchFromGitHub, bc, pkg-config }:
stdenv.mkDerivation {
  pname = "rtl8852au";
  version = "unstable";
  src = fetchFromGitHub {
    owner = "pulponair";
    repo = "rtl8852au";
    rev = "main";
    sha256 = "sha256-c2dpnZS6a0waL1khB9ZEglTwJIBsyRebTMig1B4A0xU=";
  };
  
  nativeBuildInputs = [ bc pkg-config ];
  buildInputs = [ kernel.dev ];
  
  makeFlags = [ "KVER=${kernel.version}" "KSRC=${kernel.dev}/lib/modules/${kernel.version}/build" ];
  
  preBuild = ''
    export KSRC=${kernel.dev}/lib/modules/${kernel.version}/build
  '';

  buildPhase = ''
    make ARCH=x86_64 CROSS_COMPILE= -C ${kernel.dev}/lib/modules/${kernel.version}/build M=. modules
  '';
  
  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.version}/kernel/drivers/net/wireless/realtek/rtw89
    install -m 644 8852au.ko $out/lib/modules/${kernel.version}/kernel/drivers/net/wireless/realtek/rtw89/
  '';
}
