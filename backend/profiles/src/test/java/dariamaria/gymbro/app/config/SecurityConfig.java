package dariamaria.gymbro.app.config;

import dariamaria.gymbro.app.models.Users;
import jakarta.servlet.DispatcherType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import javax.sql.DataSource;

@Configuration
//@EnableWebSecurity
//@EnableMethodSecurity
public class SecurityConfig {
//    @Autowired
//    private DataSource dataSource;
//
//    @Bean
//    public JdbcUserDetailsManager user(PasswordEncoder encoder) {
//        UserDetails admin = Users.builder()
//                .username("admin")
//                .password(encoder.encode("adm_psw"))
//                .roles("ADMIN")
//                .authorities("ADMIN")
//                .build();
//        JdbcUserDetailsManager jdbcUserDetailsManager = new JdbcUserDetailsManager(dataSource);
//        jdbcUserDetailsManager.createUser(admin);
//        return jdbcUserDetailsManager;
//    }
//
//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        return new BCryptPasswordEncoder(12);
//    }
//
//    @Bean
//    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        http
//                .authorizeHttpRequests(
//                        (authorize) -> authorize
//                                .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
//                                .requestMatchers("/admin").hasAuthority("ADMIN")
//                                .requestMatchers("/user").hasAuthority("USER")
//                                .anyRequest().authenticated())
//                .httpBasic(Customizer.withDefaults())
//                .formLogin(Customizer.withDefaults());
//        return http.build();
//    }
}
