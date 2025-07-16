package likes.app.controllers;

import com.solarwind.dto.LikesDto;
import likes.app.services.implementations.LikesServiceImp;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.mockito.Mockito.times;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(MockitoExtension.class)
public class MatchControllerTest {

    private MockMvc mockMvc;

    @Mock
    private LikesServiceImp likesService;

    @InjectMocks
    private MatchController matchController;

    @BeforeEach
    void setup() {
        mockMvc = MockMvcBuilders.standaloneSetup(matchController).build();
    }

    @Test
    void shouldCallSave() throws Exception {
        Long sender = 123L;
        Long receiver = 456L;

        mockMvc.perform(post("/")
                        .param("receiver", receiver.toString())
                        .header("Authorization-telegram-id", sender.toString()))
                .andExpect(status().isOk());

        ArgumentCaptor<LikesDto> captor = ArgumentCaptor.forClass(LikesDto.class);
        Mockito.verify(likesService, times(1)).saveOrUpdateDecision(captor.capture());

        LikesDto dto = captor.getValue();
        Assertions.assertEquals(sender, dto.getLikerId());
        Assertions.assertEquals(receiver, dto.getLikedId());
        Assertions.assertTrue(dto.getIsFirstLikes());
    }
}
