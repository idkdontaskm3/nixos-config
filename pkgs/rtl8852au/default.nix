{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
  bc,
  nukeReferences,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "rtw89";
  version = "${kernel.version}-unstable-2024-05-06";

  src = fetchFromGitHub {
    owner = "morrownr";
    repo = "rtw89";
    rev = "08b8d326937a200a706ec9c501374eec15835b5a";
    hash = "sha256-tBW2TJjqwJRyxqfLAlqHtV9h6oLIBbU+10o57sJK4Sc=";
  };
  
  nativeBuildInputs = [
    bc
    nukeReferences
  ]
  ++ kernel.moduleBuildDependencies;
  hardeningDisable = [
    "pic"
    "format"
  ];

  makeFlags = [
    "ARCH=${stdenv.hostPlatform.linuxArch}"
    ("CONFIG_PLATFORM_I386_PC=" + (if stdenv.hostPlatform.isx86 then "y" else "n"))
    ("CONFIG_PLATFORM_ARM_RPI=" + (if stdenv.hostPlatform.isAarch then "y" else "n"))
  ]
  ++ lib.optionals (stdenv.hostPlatform != stdenv.buildPlatform) [
    "CROSS_COMPILE=${stdenv.cc.targetPrefix}"
    "INSTALL_MOD_PATH=${placeholder "out"}"
  ];

  buildPhase = ''
    make -j$(nproc) -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$PWD modules
  '';

  preInstall = ''
    mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
    mkdir -p "$out/usr/lib/systemd/system-sleep"
  '';

  postInstall = ''
    nuke-refs $out/lib/modules/*/kernel/net/wireless/*.ko
  '';

  env.NIX_CFLAGS_COMPILE = "-Wno-designated-init";

  enableParallelBuilding = true;

  meta = {
    description = "Drivers for many USB WiFi devices";
    homepage = "https://github.com/morrownr/rtw89";
    license = lib.licenses.gpl2Only;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ idkdontaskm3 ];
  };
})
