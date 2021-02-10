package daangnmungcat.objectMapper;

import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import daangnmungcat.config.ContextRoot;
import daangnmungcat.dto.SaleState;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@ContextConfiguration(classes = {ContextRoot.class} )
@Log4j2
public class EnumDeserializationTest {

	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	
	@Test
	public void json_creator() throws JsonProcessingException {
		String json = "{\"saleState\": {\"code\":\"RESERVED\"}}";
		SaleState state = new ObjectMapper().readerFor(SaleState.class).readValue(json);
		assertEquals(SaleState.RESERVED, state);
	}

}
