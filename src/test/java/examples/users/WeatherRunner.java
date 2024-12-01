package examples.users;

import com.intuit.karate.junit5.Karate;

class WeatherRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("weather").relativeTo(getClass());
    }    

}
