cpucount = int(readchomp(`sysctl -n hw.physicalcpu`))
blas_set_num_threads(cpucount)
