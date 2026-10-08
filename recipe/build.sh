set -ex

echo "=== Kokkos CMake target exports ==="

find "$PREFIX/lib/cmake" -type f \
  \( -name '*Targets*.cmake' -o -name '*Config*.cmake' \) \
  | grep -i kokkos

grep -RnE \
  'IMPORTED_(IMPLIB|LOCATION)|add_library\(Kokkos::' \
  "$PREFIX/lib/cmake/Kokkos" \
  "$PREFIX/lib/cmake/KokkosKernels" || true

echo "=== Installed Kokkos libraries ==="
ls -l "$PREFIX"/lib/libkokkos*.dylib



cmake  ${CMAKE_ARGS} -S ${SRC_DIR} -B build \
-G Ninja \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=$PREFIX \
-DPACMAN_PYTHON_DIR=$SP_DIR \
-DBUILD_TESTS=OFF \
-DBUILD_FORTRAN_INTERFACE=OFF

cmake --build build

cmake --install build
