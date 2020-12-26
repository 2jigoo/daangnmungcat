package daangnmungcat.service;

import java.util.List;

import org.springframework.stereotype.Service;

import daangnmungcat.dto.Sale;

@Service
public interface JoongoSaleService {
	List<Sale> getLists();
}
