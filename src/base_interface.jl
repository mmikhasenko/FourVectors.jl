LorentzVectorBase.coordinate_system(::FourVector) = LorentzVectorBase.EXYZ()
LorentzVectorBase.px(mom::FourVector) = mom.x
LorentzVectorBase.py(mom::FourVector) = mom.y
LorentzVectorBase.pz(mom::FourVector) = mom.z
LorentzVectorBase.energy(mom::FourVector) = mom.E
