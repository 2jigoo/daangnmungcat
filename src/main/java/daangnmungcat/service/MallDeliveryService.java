package daangnmungcat.service;

import java.util.List;

import org.springframework.stereotype.Controller;

import daangnmungcat.dto.MallDelivery;

public interface MallDeliveryService {
	List<MallDelivery> selectDeliveryByAll();
}
