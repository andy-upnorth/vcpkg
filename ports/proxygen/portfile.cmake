vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO facebook/proxygen
    REF "v${VERSION}"
    SHA512 b307f1c2f50b5d8de8c56347f7cbaf743b2ee01868e817211c477a5ea22613957622392940b5b841b68b5dba0cceb66d23821d5c1967c6eaee29edbbc51fd1b8
    HEAD_REF main
    PATCHES
        remove-register.patch
        folly-has-liburing.diff
        fix-dependency.patch
)

vcpkg_find_acquire_program(PYTHON3)

vcpkg_add_to_path(PREPEND "${CURRENT_HOST_INSTALLED_DIR}/tools/gperf")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        "-DPROXYGEN_PYTHON=${PYTHON3}"
        -DVCPKG_LOCK_FIND_PACKAGE_gflags=ON
        -DCMAKE_INSTALL_DIR=share/proxygen
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup()

vcpkg_copy_tools(TOOL_NAMES hq proxygen_curl proxygen_echo proxygen_h3datagram_client proxygen_httperf2 proxygen_proxy proxygen_push proxygen_static AUTO_CLEAN)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
