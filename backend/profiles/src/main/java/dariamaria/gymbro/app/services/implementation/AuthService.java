package dariamaria.gymbro.app.services.implementation;

import com.solarwind.securityModule.models.UserSecurityNode;
import com.solarwind.securityModule.repositories.TokensRepository;
import dariamaria.gymbro.app.utils.TokenGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {
    @Autowired
    TokensRepository tokensRepository;
    
    public String obtainPersonalToken(Long userId) {
        Example<UserSecurityNode> example = Example.of(UserSecurityNode.builder().id(userId).build());
        Optional<UserSecurityNode> node = tokensRepository.findOne(example);
        return node.map(UserSecurityNode::getToken).orElse(TokenGenerator.generateToken(userId));
    }
}
