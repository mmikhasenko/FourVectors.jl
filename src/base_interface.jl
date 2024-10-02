FourMomentumBase.coordinate_system(::FourVector) = FourMomentumBase.EXYZ()
FourMomentumBase.px(mom::FourVector) = mom.x
FourMomentumBase.py(mom::FourVector) = mom.y
FourMomentumBase.pz(mom::FourVector) = mom.z
FourMomentumBase.energy(mom::FourVector) = mom.E
