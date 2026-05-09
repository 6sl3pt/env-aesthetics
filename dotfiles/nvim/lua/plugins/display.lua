local logo = [[
                                         _.oo.
                 _.u[[/;:,.         .odMMMMMM'
              .o888UU[[[/;:-.  .o@P^    MMM^  
             oN88888UU[[[/;::-.        dP^    
            dNMMNN888UU[[[/;:--.   .o@P^      
           ,MMMMMMN888UU[[/;::-. o@^          
           NNMMMNN888UU[[[/~.o@P^             
           888888888UU[[[/o@^-..              
          oI8888UU[[[/o@P^:--..               
       .@^  YUU[[[/o@^;::---..                
     oMP     ^/o@P^;:::---..                  
  .dMMM    .o@^ ^;::---...                    
 dMMMMMMM@^`       `^^^^                      
YMMMUP^                                       
 ^^                                           
]]

return {
  {
    "lukas-reineke/virt-column.nvim",
    opts = {
      virtcolumn = "80,120",
    },
  },

  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
      indent = { enabled = true },
      dashboard = {
        preset = {
          header = logo,
        },
        sections = {
          { section = "header" },
          {
            section = "terminal",
            cmd = 'text="[ $(date +"%A, %d %B %Y") ]"; printf "%*s\n" $(( (${#text} + 60) / 2 )) "$text"',
            height = 1,
            width = 60,
            gap = 1,
            padding = 1,
            align = "center",
          },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      pickers = {
        sources = {
          projects = {
            confirm = function(picker, item)
              picker:action("load_session")

              if item and item.path then
                vim.fn.chdir(item.path)
              end
            end,
          },
        },
      },
    },
  },
}
