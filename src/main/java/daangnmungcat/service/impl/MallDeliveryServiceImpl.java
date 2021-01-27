package daangnmungcat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.MallDelivery;
import daangnmungcat.mapper.MallDeliveryMapper;
import daangnmungcat.service.MallDeliveryService;

@Service
public class MallDeliveryServiceImpl implements MallDeliveryService {
	
	@Autowired
	private MallDeliveryMapper mapper;

	@Override
	public List<MallDelivery> selectDeliveryByAll() {
		return mapper.selectDeliveryByAll();
	}

}
