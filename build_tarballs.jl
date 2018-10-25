# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "Boost"
version = v"1.68.0-0"

# Collection of sources required to build Boost
sources = [
    "https://dl.bintray.com/boostorg/release/1.68.0/source/boost_1_68_0.tar.bz2" =>
    "7f6130bc3cf65f56a618888ce9d5ea704fa10b462be126ad053e80e553d6d8b7",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/boost_1_68_0/
./bootstrap.sh --prefix=$prefix
./b2 -j$nproc --layout=system install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:i686, libc=:glibc),
    Linux(:x86_64, libc=:glibc),
    Linux(:x86_64, libc=:musl)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libboost_math_tr1f", :math_tr1f),
    LibraryProduct(prefix, "libboost_thread", :thread),
    LibraryProduct(prefix, "libboost_unit_test_framework", :unit_test_framework),
    LibraryProduct(prefix, "libboost_type_erasure", :type_erasure),
    LibraryProduct(prefix, "libboost_chrono", :chrono),
    LibraryProduct(prefix, "libboost_math_c99l", :math_c99l),
    LibraryProduct(prefix, "libboost_locale", :locale),
    LibraryProduct(prefix, "libboost_program_options", :program_options),
    LibraryProduct(prefix, "libboost_date_time", :date_time),
    LibraryProduct(prefix, "libboost_graph", :graph),
    LibraryProduct(prefix, "libboost_signals", :signals),
    LibraryProduct(prefix, "libboost_iostreams", :iostreams),
    LibraryProduct(prefix, "libboost_stacktrace_addr2line", :stacktrace_addr2line),
    LibraryProduct(prefix, "libboost_system", :system),
    LibraryProduct(prefix, "libboost_wave", :wave),
    LibraryProduct(prefix, "libboost_wserialization", :wserialization),
    LibraryProduct(prefix, "libboost_math_tr1l", :math_tr1l),
    LibraryProduct(prefix, "libboost_math_tr1", :math_tr1),
    LibraryProduct(prefix, "libboost_filesystem", :filesystem),
    LibraryProduct(prefix, "libboost_random", :random),
    LibraryProduct(prefix, "libboost_coroutine", :coroutine),
    LibraryProduct(prefix, "libboost_serialization", :serialization),
    LibraryProduct(prefix, "libboost_context", :context),
    LibraryProduct(prefix, "libboost_container", :container),
    LibraryProduct(prefix, "libboost_stacktrace_noop", :stacktrace_noop),
    LibraryProduct(prefix, "libboost_contract", :contract),
    LibraryProduct(prefix, "libboost_prg_exec_monitor", :prg_exec_monitor),
    LibraryProduct(prefix, "libboost_regex", :regex),
    LibraryProduct(prefix, "libboost_log_setup", :log_setup),
    LibraryProduct(prefix, "libboost_math_c99", :math_c99),
    LibraryProduct(prefix, "libboost_timer", :timer),
    LibraryProduct(prefix, "libboost_stacktrace_basic", :stacktrace_basic),
    LibraryProduct(prefix, "libboost_math_c99f", :math_c99f),
    LibraryProduct(prefix, "libboost_log", :log),
    LibraryProduct(prefix, "libboost_atomic", :atomic)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

