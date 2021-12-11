# ==============================================================================
# -- Get FAST_RTPS and compile it with libc++ --------------------------------------
# ==============================================================================
CXX_TAG=c8
export CC=/usr/bin/clang-8
export CXX=/usr/bin/clang++-8

# fast_rtps
FAST_RTPS_VERSION=v2.4.1
FAST_RTPS_BASENAME=fast_rtps-${FAST_RTPS_VERSION}-${CXX_TAG}

FAST_RTPS_LIBCXX_INCLUDE=${PWD}/${FAST_RTPS_BASENAME}-libcxx-install/include
FAST_RTPS_LIBCXX_LIBPATH=${PWD}/${FAST_RTPS_BASENAME}-libcxx-install/lib

FAST_RTPS_LIBSTDCXX_INCLUDE=${PWD}/${FAST_RTPS_BASENAME}-libstdcxx-install/include
FAST_RTPS_LIBSTDCXX_LIBPATH=${PWD}/${FAST_RTPS_BASENAME}-libstdcxx-install/lib

# fast_cdr
FAST_CDR_VERSION=v1.0.22
FAST_CDR_BASENAME=fast_cdr-${FAST_CDR_VERSION}-${CXX_TAG}

FAST_CDR_LIBCXX_INCLUDE=${PWD}/${FAST_CDR_BASENAME}-libcxx-install/include
FAST_CDR_LIBCXX_LIBPATH=${PWD}/${FAST_CDR_BASENAME}-libcxx-install/lib

FAST_CDR_LIBSTDCXX_INCLUDE=${PWD}/${FAST_CDR_BASENAME}-libstdcxx-install/include
FAST_CDR_LIBSTDCXX_LIBPATH=${PWD}/${FAST_CDR_BASENAME}-libstdcxx-install/lib

# foonathan_memory_vendor

FOONATHAN_MEMORY_VERSION="master"
FOONATHAN_MEMORY_BASENAME=foonathan_memory_vendor-${FOONATHAN_MEMORY_VERSION}-${CXX_TAG}

FOONATHAN_MEMORY_LIBCXX_INCLUDE=${PWD}/${FOONATHAN_MEMORY_BASENAME}-libcxx-install/include
FOONATHAN_MEMORY_LIBCXX_LIBPATH=${PWD}/${FOONATHAN_MEMORY_BASENAME}-libcxx-install/lib

FOONATHAN_MEMORY_LIBSTDCXX_INCLUDE=${PWD}/${FOONATHAN_MEMORY_BASENAME}-libstdcxx-install/include
FOONATHAN_MEMORY_LIBSTDCXX_LIBPATH=${PWD}/${FOONATHAN_MEMORY_BASENAME}-libstdcxx-install/lib

if [[ -d "${FAST_RTPS_BASENAME}-libcxx-install" && -d "${FAST_RTPS_BASENAME}-libstdcxx-install" ]]; then
    echo "${FAST_RTPS_BASENAME} already installed."
else
    rm -Rf \
        ${FAST_RTPS_BASENAME}-libcxx-install ${FAST_RTPS_BASENAME}-libstdcxx-install \
        ${FAST_CDR_BASENAME}-libcxx-build ${FAST_CDR_BASENAME}-libstdcxx-build \
        ${FAST_CDR_BASENAME}-libcxx-install ${FAST_CDR_BASENAME}-libstdcxx-install \
        ${FOONATHAN_MEMORY_BASENAME}-libcxx-build ${FOONATHAN_MEMORY_BASENAME}-libstdcxx-build \
        ${FOONATHAN_MEMORY_BASENAME}-libcxx-install ${FOONATHAN_MEMORY_BASENAME}-libstdcxx-install

    # install dependencies
    apt install libasio-dev libtinyxml2-dev


    # build fast_cdr

    if [ -d ${FAST_CDR}-source ]; then
        echo "${FAST_CDR_BASENAME}-source already existence"
    else
        echo "====================Retrieving FAST_CDR.=============================="
        git clone --depth=1 -b ${FAST_CDR_VERSION} https://github.com/eProsima/Fast-CDR.git ${FAST_CDR_BASENAME}-source
    fi

    echo "====================Building Fast_CDR with libstdc++.==============="

    mkdir -p ${FAST_CDR_BASENAME}-libstdcxx-build

    pushd ${FAST_CDR_BASENAME}-libstdcxx-build >/dev/null

    cmake \
        -DCMAKE_CXX_FLAGS="-std=c++14" \
        ../${FAST_CDR_BASENAME}-source

    cmake --build . --target install DESTDIR="../${FAST_CDR_BASENAME}-libstdcxx-install" 

    rm -Rf ${FAST_CDR_BASENAME}-libcxx-build ${FAST_CDR_BASENAME}-libstdcxx-build

    popd >/dev/null

    # build foonathan_memory_vendor

    if [ ! -d "${FOONATHAN_MEMORY}-source" ]; then

        echo "====================Retrieving foonathan_memory_vendor.=============================="
        git clone https://github.com/eProsima/foonathan_memory_vendor.git ${FOONATHAN_MEMORY_BASENAME}-source

    fi

    echo "====================Building foonathan_memory_vendor with libstdc++.==============="

    mkdir -p ${FOONATHAN_MEMORY_BASENAME}-libstdcxx-build

    pushd ${FOONATHAN_MEMORY_BASENAME}-libstdcxx-build >/dev/null

    cmake \
        -DCMAKE_CXX_FLAGS="-std=c++14" \
        ../${FOONATHAN_MEMORY_BASENAME}-source

    cmake --build . --target install DESTDIR="../${FOONATHAN_MEMORY_BASENAME}-libstdcxx-install"

    rm -Rf ${FOONATHAN_MEMORY_BASENAME}-libcxx-build ${FOONATHAN_MEMORY_BASENAME}-libstdcxx-build

    popd >/dev/null

    # build fast_rtps
    if [ ! -d "${FAST_RTPS_BASENAME}-source" ]; then

        echo "===========================Retrieving FAST_RTPS.======================"
        git clone --depth=1 -b ${FAST_RTPS_VERSION} https://github.com/eProsima/Fast-DDS.git ${FAST_RTPS_BASENAME}-source

    fi

    echo "====================Building fast_rtps with libstdc++.==============="

    mkdir -p ${FAST_RTPS_BASENAME}-libstdcxx-build

    pushd ${FAST_RTPS_BASENAME}-libstdcxx-build >/dev/null

    cmake \
        -DCMAKE_CXX_FLAGS="-std=c++14" \
        -DCMAKE_PREFIX_PATH="../${FAST_CDR_BASENAME}-libstdcxx-install;../${FOONATHAN_MEMORY_BASENAME}-libstdcxx-install" \
        ../${FAST_RTPS_BASENAME}-source


    cmake --build . --target install  DESTDIR="../${FAST_RTPS_BASENAME}-libstdcxx-install"


    popd >/dev/null

    # rm -Rf \
    #     ${FAST_RTPS_BASENAME}-libcxx-build ${FAST_RTPS_BASENAME}-libstdcxx-build \
    #     ${FAST_CDR_BASENAME}-libcxx-build ${FAST_CDR_BASENAME}-libstdcxx-build \
    #     ${FOONATHAN_MEMORY_BASENAME}-libcxx-build ${FOONATHAN_MEMORY_BASENAME}-libstdcxx-build

fi
