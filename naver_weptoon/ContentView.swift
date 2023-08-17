//
//  ContentView.swift
//  naver_weptoon
//
//  Created by 최영호 on 2023/08/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let _ = print("screen width : \(UIScreen.main.bounds.width)")
        GeometryReader{out_proxy in
            ScrollView{
                VStack(spacing: 0){
                    
                    First_View()
                    
                    VStack{
                        Color.green
                    }
                    .frame(width: UIScreen.main.bounds.width,
                           height: 200)
                }
                VStack{
                    Color.blue
                }
                .frame(width: UIScreen.main.bounds.width,
                       height: 1000)
            }
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct First_View :View{
    
    @State private var capsule_view_pagging_count : Int = 0
    @State private var page_label : [Int] = [0,1,2,3,4,5,6,7,8,9]
    @State private var draggedOffset = CGSize.zero
    @State private var accumulatedOffset = CGSize.zero
    @State var num = 0
    @State var drag_on : Bool = false
    @State var start_now_posiotn : Int = 2
    
    var body: some View{
        VStack{
            //            Color.red
            GeometryReader{proxy in
                ZStack{
                    Color(.yellow)
                    VStack{
                        Color.white.opacity(0)
                        Spacer(minLength: 90)
                        capsult_plus_banner(offset_binding: $draggedOffset)
                    }
                }
                .animation(.default, value: draggedOffset)
                .gesture(
                    
                    DragGesture()
                        .onChanged { value in
                            drag_on.toggle()
                            let _ = print("drag")
//                            print("start now postion : \(start_now_posiotn.width), drag off set : \(draggedOffset.width)")
//                            start_now_posiotn.width = draggedOffset.width
                            
                            
                            draggedOffset.width = draggedOffset.width + value.translation.width
                            if(value.predictedEndTranslation.width > 50){
                                draggedOffset.width += 1
                                print("to fast")
                            }
                            
                            
                    
                            
                            if(draggedOffset.width > 860){
                                draggedOffset.width = 860
                            }
                            else if(draggedOffset.width < -430){
                                draggedOffset.width = -430
                            }
                        }
                        .onEnded({ value in
                            let _ = print("end \(value)")
//                            accumulatedOffset.width = accumulatedOffset.width + value.translation.width
                            
                            if(value.translation.width > 0)
                            {
                                print("round \(round(CGFloat(start_now_posiotn * 430) / 2))")
                                print( draggedOffset.width + 430)
                                
                                if((draggedOffset.width + 430 > (round(CGFloat(start_now_posiotn * 430) / 2))) == true){
                                    start_now_posiotn += 1
                                    print("moving left")
                                }
                            }
                            
                            
                            if(value.translation.width > 0){
                                print("left move \(draggedOffset.width)")
//                                start_now_posiotn += 1
                                draggedOffset.width = CGFloat(start_now_posiotn * 430)
                                print("drag off set \(draggedOffset.width), \(round(draggedOffset.width/430))")
                            }else{
                                print("right move")
                                start_now_posiotn -= 1
                                draggedOffset.width = CGFloat(start_now_posiotn * 430)
                                print("right drag off set \(draggedOffset.width), \(round(draggedOffset.width/430))")
                            }
                            
                            if(draggedOffset.width > 860){
                                draggedOffset.width = 860
                            }
                            else if(draggedOffset.width < -430){
                                draggedOffset.width = -430
                            }
                            
                            drag_on.toggle()
                        })
                )
                
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               height: 270)
    }
}

func test2(Num : Int) -> Int{

    return Num
}

func test1(Num : Binding<Int>) -> Binding<Int>{
    
    let num = Num
    
    return num
}

struct capsult_plus_banner: View{
    @Binding var offset_binding : CGSize
    
    
    var body: some View{
        VStack(alignment: .trailing, spacing: 0){
            
            VStack{
                //                Color.blue
                capsule_view(temp_num: 0)
            }
            
            VStack(spacing: 0){
                //                            Color(.blue)
                
                banner_view(count_num: 0, offset_binding: $offset_binding)
                
            }
        }
    }
}

struct capsule_view: View{
    var temp_num : Int
//    @Binding var num : Int
//    @State var temp_num = 0
    var body: some View{
        
        VStack{
            Capsule()
                .frame(width: 60, height: 25)
                .opacity(0.2)
        }
        .padding(.trailing, 10)
        .padding(.bottom, 5)
    }
    
    
}

struct banner_view :View{
    var count_num : Int
    @Binding var offset_binding : CGSize
    @State private var maxNumber: Int = 3
    var body: some View{
        VStack{
//            let _ = print("banner view offset : \(offset_binding)")
            GeometryReader{i in
                ScrollViewReader{proxy in
                    ScrollView{
                        LazyHStack(spacing: 0){
                            ForEach(0...maxNumber, id: \.self){num in
                                banner_rectangle_view(num: num, offset_binding: $offset_binding)
//                                    .onAppear {
//                                        if num % 10 == 9 {
//                                            maxNumber += 10
//                                        }
//                                    }
                            }
                        }
                        .scrollDisabled(true)
                        .frame(width: UIScreen.main.bounds.width)
                        .offset(offset_binding)
                    }
                }
            }
        }
    }
}

struct banner_rectangle_view : View{
    var num : Int
    @Binding var offset_binding : CGSize
    var body: some View{
        
        ZStack{
            Color.red
            Rectangle()
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width - 30, height: 50)
            HStack{
                Text("\(num)")
                    .foregroundColor(.white)
                Text("center postion : \(offset_binding.width)")
                    .foregroundColor(.white)
            }
//            let _ = print("banner_rectangle_view center postion : \(offset_binding)")
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

func postion_clac(num : Int) -> Int{
    
    return 0
}


func banner_text(num : Int) -> String{
    let banner_text : [String] = []
    var result_text = ""
    
    return result_text
}
