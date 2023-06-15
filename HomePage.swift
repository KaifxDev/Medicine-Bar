import SwiftUI

struct HomePage: View {
    @ObservedObject private var viewModel = HomepageViewModel()
    @State private var selectedTab = 0
    
    @Environment(\.colorScheme)
    var colorScheme
    
    var body: some View {
        TabView(selection: $selectedTab) {
            //NavigationView {
                // Menu view content
                MenuView()
                    .navigationBarTitle("Menu")
            //}
            .tabItem {
                Image(systemName: "list.dash")
                Text("Menu")
            }
            .tag(0)
            
            //NavigationView {
                ScrollView {
                    VStack {
                        FeaturedEventsRow(events: viewModel.featuredEvents)
                        
                        PopularEventsRow(events: viewModel.popularEvents)
                        
                        UpcomingEventRow(events: viewModel.upcomingEvents)
                    }
                    .padding()
                }
                .navigationBarTitle("Home")
                .navigationBarItems(trailing: Button(action: {
                    viewModel.refreshData()
                }) {
                    Image(systemName: "arrow.clockwise")
                })
            //}
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(1)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(2)
                .accentColor(colorScheme == .dark ? .white : .black)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .environmentObject(Basket())
    }
}

struct FeaturedEventsRow: View {
    var events: [Event]
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionHeader(title: "Featured Events")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(events) { event in
                        NavigationLink(destination: EventDetailsView(event: event)) {
                            FeaturedEventCard(event: event)
                        }
                    }
                }
            }
            .frame(height: 180)
        }
    }
}

struct PopularEventsRow: View {
    var events: [Event]
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionHeader(title: "Popular Events")
            
            ForEach(events) { event in
                NavigationLink(destination: EventDetailsView(event: event)) {
                    PopularEventCard(event: event)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct UpcomingEventsRow: View {
    let event: Event
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(event.dateString)
                    .foregroundColor(.secondary)
                
                Text(event.location)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
                
                HStack {
                    ForEach(event.tags, id: \.self) { tag in
                        Text(tag)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue)
                            .cornerRadius(4)
                    }
                }

                .padding(.top, 8)
            }
            .padding()
            
            Spacer()
            
            Image(event.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
        }
        .background(Color("CardBackground"))
        .cornerRadius(16)
        .shadow(color: Color("CardShadow"), radius: 8, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.top)
    }
}



struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.bold)
            .padding(.bottom, 5)
    }
}

struct FeaturedEventCard: View {
    let event: Event
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("CardBackground"))
            
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack {
                    Image(systemName: "calendar")
                    Text(event.dateString)
                }
                
                HStack {
                    Image(systemName: "location")
                    Text(event.location)
                }
            }
            .padding()
        }
        .frame(width: 300, height: 150)
        .shadow(color: Color("ShadowTop"), radius: 8, x: -5, y: -5)
        .shadow(color: Color("ShadowBottom"), radius: 8, x: 5, y: 5)
    }
}

struct PopularEventCard: View {
    let event: Event
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(event.formattedDate)
                    .foregroundColor(.secondary)
                
                Text(event.location)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
                
                HStack {
                    ForEach(Array(event.tags.enumerated()), id: \.offset) { index, tag in
                        Text(tag)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue)
                            .cornerRadius(4)
                    }
                }
                .padding(.top, 8)
            }
            .padding()
            
            Spacer()
            
            Image(event.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
        }
        .background(Color("CardBackground"))
        .cornerRadius(16)
        .shadow(color: Color("CardShadow"), radius: 8, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.top)
    }
}

